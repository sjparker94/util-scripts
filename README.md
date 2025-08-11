# Util scripts

## copy_envs.sh

This script recursively searches a given directory for subdirectories containing both a `.git` directory and one or more `.env*` files (excluding `.env.example`). It copies each found `.env*` file into a central `env_files_export` directory in your current working directory, preserving the original filename and appending the source directory name. The files are organized one level deep by the parent directory of the source.

### Features

- Recursively searches for `.git` directories.
- Copies `.env` and `.env.*` files (excluding `.env.example`).
- Output files are named `{original_env_filename}.{source_directory}`.
- Files are organized in `env_files_export/{parent}/` where `{parent}` is the immediate parent of the source directory.
- The `env_files_export` directory is created in the directory where you run the script.

### Usage

```sh
chmod +x copy_envs.sh
./copy_envs.sh /path/to/search
```

- Replace `/path/to/search` with the root directory you want to search.
- The copied files will appear in `./env_files_export/{parent}/` relative to your current directory.

### Example

Suppose you have the following structure:

```
/project
  /service1
    /.git
    /.env
    /.env.local
  /service2
    /.git
    /.env
```

Running:

```sh
cd /project
./copy_envs.sh .
```

Will produce:

```
/project/env_files_export/project/
  .env.service1
  .env.local.service1
  .env.service2
```

### Notes

- Only `.env` and `.env.*` files are copied (not `.env.example`).
- The script must be run with a directory argument.
- Existing files in `env_files_export` with the same name will be overwritten.

### How to Add a `copy_envs` Alias to Your `.zshrc`

This alias lets you run the `copy_envs.sh` script from anywhere. The script takes one argument: the directory to search for `.env` files.

#### Steps

1. Open your `.zshrc` file:

   ```sh
   # neovim, btw
   nvim ~/.zshrc
   ```

2. Add this line at the end (replace `/path/to/your/script` with the actual path to `copy_envs.sh`):

   ```zsh
   alias copy_envs="/path/to/your/script/copy_envs.sh"
   ```

3. Save and close the file.

4. Reload your shell configuration:
   ```sh
   source ~/.zshrc
   ```

#### Usage

Run the script by providing the directory to search:

```sh
copy_envs /path/to/search/directory
```

```

```
