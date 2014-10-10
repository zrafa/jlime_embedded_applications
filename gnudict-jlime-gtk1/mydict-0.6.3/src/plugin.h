#ifdef __PLUGIN_H
#define __PLUGIN_H

MydictPlugin * plugin_load(const char pluginFile[]);
void plugin_closeall();
#endif
