/*
 * channels_mount.h
 *
 *  Created on: 19.09.2012
 *      Author: yaroslav
 */

#ifndef CHANNELS_MOUNT_H_
#define CHANNELS_MOUNT_H_

#include <fcntl.h>
#include "mounts_interface.h"

#define FIRST_NON_RESERVED_INODE 11
#define INODE_FROM_HANDLE(handle) (FIRST_NON_RESERVED_INODE+handle)

struct ZVMChannel;
struct HandleAllocator;

struct MountsInterface* alloc_channels_mount( struct HandleAllocator* handle_allocator,
        const struct ZVMChannel* channels, int channels_count );

/*used by mapping nvram section for setting custom channel type*/
uint* channel_mode(const char* channel_name);

#endif /* CHANNELS_MOUNT_H_ */
