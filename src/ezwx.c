#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <stdlib.h>
#include <libgen.h>
#include <sys/stat.h>

#define LUA_LIB
#include "lua/lua.h"
#include "lua/lauxlib.h"

#include "ezWxLua.c"

static int change_dir (lua_State *L) {
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		const char *path = luaL_checkstring(L, 1);
		lua_pushinteger(L, chdir(path));
		lua_pushstring(L, strerror(errno));		
		return 2;
		/*
		if ( chdir(path) ) {
			lua_pushnil (L);
			lua_pushfstring (L,"Unable to change working directory to '%s'\n", path);
			return 2;
		} else {
			lua_pushboolean (L, 1);
			return 1;
		}
		*/
	}
	return 0;
}

static int current_dir (lua_State *L) {
	char path[1024];
	if( getcwd(path, sizeof(path)) != NULL ) {
		lua_pushstring(L, path);
		return 1;
	}
	return 0;
}

static int make_dir (lua_State *L) {
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		const char *path = luaL_checkstring(L, 1);
		lua_pushinteger(L, mkdir(path));
		lua_pushstring(L, strerror(errno));
		return 2;
	}
	return 0;
}

static int remove_dir (lua_State *L) {
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		const char *path = luaL_checkstring(L, 1);
		lua_pushinteger(L, rmdir(path));
		lua_pushstring(L, strerror(errno));
		return 2;
	}
	return 0;
}

static void add_file(lua_State *L, const struct dirent *dp, const char *path) 
{
	struct stat stat_buf;
	char full_name[1024];
	snprintf( full_name, sizeof(full_name), "%s/%s", path, dp->d_name);
	if( stat( full_name, &stat_buf) == 0 ) {
		printf("C: %s\n", dp->d_name);
		lua_pushstring(L, dp->d_name);
		lua_newtable(L);

		lua_pushstring(L, "path");
		lua_pushstring(L, full_name);
		lua_rawset(L, -3);
		
		lua_pushstring(L, "size");
		lua_pushnumber(L, stat_buf.st_size);
		lua_rawset(L, -3);
		
		lua_pushstring(L, "time");
		lua_pushnumber(L, stat_buf.st_mtime);
		lua_rawset(L, -3);

		lua_pushstring(L, "mode");
		lua_pushnumber(L, stat_buf.st_mode);
		lua_rawset(L, -3);

		lua_rawset(L, -3);	
	}
}

static int list_dir (lua_State *L) 
{
	struct stat stat_buf;
	struct dirent *dp;
	DIR *dirp;
	char full_name[1024];
	
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		const char *path = luaL_checkstring(L, 1);
		if( stat( path, &stat_buf) == 0 && S_ISDIR(stat_buf.st_mode) == 0 ) {
			return 0;
		}

		if( (dirp=opendir(path)) != NULL ) {
			lua_newtable(L);
			while( (dp=readdir(dirp)) != NULL ) {
				if( strcmp( dp->d_name, "." ) == 0 ) {
					continue;
				}
				if( strcmp( dp->d_name, ".." ) == 0 ) {
					continue;
				}
				add_file( L, dp, path);
			} 
			closedir(dirp);
			return 1;
		}
		
	}
	return 0;
}

static int is_dir(lua_State *L) 
{
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		struct stat stat_buf;
		const char *path = luaL_checkstring(L, 1);
		if( stat( path, &stat_buf) == 0 && S_ISDIR(stat_buf.st_mode) ) {
			lua_pushnumber(L, 1);
		} else {
			lua_pushnumber(L, 0);
		}
		return 1;
	}
	return 0;
}

static int file_exist(lua_State *L) 
{
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		const char *path = luaL_checkstring(L, 1);
		if( access(path, F_OK) == 0 ) {
			lua_pushnumber(L, 1);
		} else {
			lua_pushnumber(L, 0);
		}
		return 1;
	}
	return 0;
}

static int file_stat(lua_State *L) 
{
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		struct stat stat_buf;
		const char *path = luaL_checkstring(L, 1);
		if( stat( path, &stat_buf) == 0 ) {
			lua_newtable(L);

			lua_pushstring(L, "path");
			lua_pushstring(L, path);
			lua_rawset(L, -3);
			
			lua_pushstring(L, "size");
			lua_pushnumber(L, stat_buf.st_size);
			lua_rawset(L, -3);
			
			lua_pushstring(L, "time");
			lua_pushnumber(L, stat_buf.st_mtime);
			lua_rawset(L, -3);

			lua_pushstring(L, "mode");
			lua_pushnumber(L, stat_buf.st_mode);
			lua_rawset(L, -3);

			return 1;
		}
	}
	return 0;
}

static int file_size(lua_State *L) 
{
	int argc = lua_gettop(L);
	if( argc == 1 ) {
		struct stat stat_buf;
		const char *path = luaL_checkstring(L, 1);
		if( stat( path, &stat_buf) == 0 ) {
			lua_pushnumber(L, stat_buf.st_size);
			return 1;
		}
	}
	return 0;
}

struct luaL_Reg funcs[] = {
  { "chdir"  , change_dir },
  { "getcwd" , current_dir },
  { "lsdir"  , list_dir },
  { "mkdir"  , make_dir },
  { "rmdir"  , remove_dir },

  { "isdir"  , is_dir },
  
  { "exist"  , file_exist },
  { "stat"   , file_stat },
  { "size"   , file_size },

  { NULL, NULL }
};

LUALIB_API int luaopen_ezwx(lua_State *L)
{
  luaL_newlib(L, funcs);
  luaL_dostring(L, ezWxLua);
  return 1;
}
