include core/arch/$(ARCH)/plat-$(PLATFORM)/platform_flags.mk

core-platform-cppflags	+= -I$(arch-dir)/include
core-platform-subdirs += \
	$(addprefix $(arch-dir)/, kernel mm tee sta) $(platform-dir)
core-platform-subdirs += $(arch-dir)/sm

$(call force,CFG_ARM32_core,y)
$(call force,CFG_SECURE_TIME_SOURCE_REE,y)
$(call force,CFG_PL310,y)
$(call force,CFG_CACHE_API,y)
$(call force,CFG_PM_STUBS,y)
$(call force,CFG_GENERIC_BOOT,y)
$(call force,CFG_MMU_V7_TTB,y)
$(call force,CFG_BOOT_SYNC_CPU,y)

ta-targets = ta_arm32

libtomcrypt_with_optimize_size ?= y
CFG_TEE_CORE_EMBED_INTERNAL_TESTS ?= y
CFG_WITH_STACK_CANARIES ?= y
CFG_WITH_STATS ?= y
CFG_WITH_SOFTWARE_PRNG ?= n
CFG_TEE_GDB_BOOT ?= y

include mk/config.mk
include $(platform-dir)/system_config.mk
