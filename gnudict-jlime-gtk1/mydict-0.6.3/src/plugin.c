#include "plugin.h"
#include "mydict_plugin.h"
#include <stdio.h>
#include <dlfcn.h> // dynamic library stuff
#include "mydict.h"

//----------------------------------------------------------------------------
// This hard-coded plugin info should be replaced with some sort
// of plugin 'registry', possibly just a text file, or a
// scan through all the .so files in the plugins directory.
//----------------------------------------------------------------------------

void *handleList[100];
int numberofhandle=0;
void plugin_closeall()
{
	int i=0;
	for(i=0;i<numberofhandle;i++)
		if ( handleList[i] != NULL)
		{
			dlclose( handleList[i] );
			handleList[i] = NULL;
		}	
	numberofhandle = 0;	
}
MydictPlugin * plugin_load(const char pluginFile[])
{
	CREATEPLUG_PROC createproc;
	MydictPlugin *  myPlugins;
	
	void *          handle;
	char *          error;

	// Load plugin dynamic library
	if (NULL == (handle = dlopen(pluginFile, RTLD_LAZY )))
	{
		handle = NULL;
		printf( "dlopen error (%s)\n", pluginFile );
		error=dlerror();
		printf("error : %s\n",error);
		return NULL;
	}
	else
	{
		// Get address of CreatePlug function
		createproc = (CREATEPLUG_PROC)dlsym( handle, "CreateMydictPlug" );
		if ((error = dlerror()) != NULL)
		{
			dlclose( handle );
			handle = NULL;
			printf( "dlsym error (%s)\n", pluginFile );
			printf("error : %s\n",error);
			return NULL;
		}
		else
		{
			// Create an instance of the derived plugin class
			myPlugins = createproc();
			handleList[numberofhandle++]=handle;
			return myPlugins;
		}
	}


/*    // "Run" the plugins
   printf( "Running plugins ..\n" );
   for ( i=0; i<NUM_PLUGINS; i++ )
   {
      if (handle != NULL)
      {
	 	printf("return %d\n",pPlugins[i]->Action());
      }
	  if(i==3) {
	  	char str[100]="Hello world";
	  	printf("return %d\n",pPlugins[i]->Action(str));
		printf("str=%s\n",str);
		}
   }
 */
   // Close plugin library files
/*    for ( i=0; i<NUM_PLUGINS; i++ )
   {
      if (handle != NULL)
      {
	 	dlclose( handle );
	 	handle = NULL;
      }
   } */
}
