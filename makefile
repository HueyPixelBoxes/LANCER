# Define the source file and destination directory
SOURCE_DIR := "D:\Game\GameMaker\LITB\LANCER"
DEST_DIR := "D:\Game\Gaming game\Into the Breach\mods\LANCER"

# Rule to copy the file
all:
	@xcopy $(SOURCE_DIR) $(DEST_DIR) /e /i /y /q
	del /q $(DEST_DIR)\makefile
	@echo Files copied successfully!