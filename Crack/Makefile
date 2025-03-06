CC = g++

# Флаги компиляции (убрал дубли и добавил -I)
CFLAGS = -Wshadow -Winit-self -Wredundant-decls -Wcast-align -Wundef -Wfloat-equal -Winline -Wunreachable-code \
         -Wmissing-declarations -Wmissing-include-dirs -Wswitch-enum -Wswitch-default -Weffc++ -Wmain -Wextra -Wall \
         -g -pipe -fexceptions -Wcast-qual -Wconversion -Wctor-dtor-privacy -Wempty-body -Wformat-security \
         -Wformat=2 -Wignored-qualifiers -Wlogical-op -Wnon-virtual-dtor -Woverloaded-virtual -Wpointer-arith \
         -Wsign-promo -Wstack-usage=8192 -Wstrict-aliasing -Wstrict-null-sentinel -Wtype-limits -Wwrite-strings \
         -Werror=vla -D_DEBUG -D_EJUDGE_CLIENT_SIDE -I C:/SFML-3.0.0/include

# Флаги линковки (путь к SFML и ее библиотеки)
LDFLAGS = -L C:/SFML-3.0.0/lib -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

# Пути
SOURCE_DIR = source
BUILD_DIR = build
HEADERS_DIR = include

# Включение заголовков
INCLUDE = -I include
CFLAGS += $(INCLUDE)

# Файлы проекта
HEADERS = $(wildcard $(HEADERS_DIR)/*.h)
SOURCES = $(wildcard $(SOURCE_DIR)/*.cpp)
OBJECTS = $(patsubst $(SOURCE_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SOURCES))

# Исполняемый файл
EXEC_NAME := crack.exe

.PHONY: clean all run

all: $(BUILD_DIR)/$(EXEC_NAME)

$(BUILD_DIR)/$(EXEC_NAME): $(OBJECTS) | $(BUILD_DIR)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

run:
	$(BUILD_DIR)/$(EXEC_NAME) $(FILE)
