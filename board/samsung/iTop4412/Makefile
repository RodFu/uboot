#
# Copyright (C) 2011 Samsung Electronics
#
# SPDX-License-Identifier:	GPL-2.0+
#

ifdef CONFIG_SPL_BUILD
# necessary to create built-in.o
obj- := __dummy__.o

hostprogs-y := tools/mkiTop4412spl
always := $(hostprogs-y)

# omit -O2 option to suppress
#   warning: dereferencing type-punned pointer will break strict-aliasing rules
#
# TODO:
# Fix the root cause in tools/mkiTop4412spl.c and delete the following work-around
$(obj)/tools/mkiTop4412spl: HOSTCFLAGS:=$(filter-out -O2,$(HOSTCFLAGS))
else
obj-y	+= iTop4412.o
endif
