# ARM64 Assembly Makefile
# Supports both macOS (Apple Silicon) and Linux ARM64

UNAME_S := $(shell uname -s)

# macOS programs
MACOS_SRCS := $(wildcard *.s)
MACOS_OBJS := $(MACOS_SRCS:.s=.o)
MACOS_BINS := $(MACOS_SRCS:.s=.x)

# Linux programs
LINUX_SRCS := $(wildcard linux/*.s)
LINUX_OBJS := $(LINUX_SRCS:.s=.o)
LINUX_BINS := $(LINUX_SRCS:.s=.x)

ifeq ($(UNAME_S),Darwin)
  AS = as -arch arm64
  LD = ld -lSystem -syslibroot $(shell xcrun --show-sdk-path) -e _start -arch arm64
  SRCS := $(MACOS_SRCS)
  OBJS := $(MACOS_OBJS)
  BINS := $(MACOS_BINS)
else ifeq ($(UNAME_S),Linux)
  AS = as
  LD = ld
  SRCS := $(LINUX_SRCS)
  OBJS := $(LINUX_OBJS)
  BINS := $(LINUX_BINS)
endif

.PHONY: all macos linux clean help

all: $(BINS)
	@echo "Built: $(BINS)"

# macOS targets
macos: $(MACOS_BINS)
	@echo "Built macOS programs: $(MACOS_BINS)"

# Linux targets
linux: $(LINUX_BINS)
	@echo "Built Linux programs: $(LINUX_BINS)"

# Pattern rules
%.o: %.s
	$(AS) -o $@ $<

%.x: %.o
	$(LD) -o $@ $<

clean:
	rm -f *.o *.x linux/*.o linux/*.x

help:
	@echo "ARM64 Assembly Build System"
	@echo ""
	@echo "Targets:"
	@echo "  all     - Build programs for the detected platform"
	@echo "  macos   - Build all macOS (Apple Silicon) programs"
	@echo "  linux   - Build all Linux ARM64 programs"
	@echo "  clean   - Remove all compiled objects and executables"
	@echo "  help    - Show this help message"
	@echo ""
	@echo "Detected platform: $(UNAME_S)"
