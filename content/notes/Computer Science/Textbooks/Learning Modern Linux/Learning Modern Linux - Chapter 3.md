---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - linux
title: Learning Modern Linux - Chapter 3
date: 2025-06-03
updated: 2025-06-16T13:09
---

-------------------------------------------------------------------------------

# Shells and Scripting

A huge part of getting comfortable with Linux is getting comfortable using the *command line*, or *CLI*. Most common distros today will have some standard GUI application to accomplish most tasks. However, like we discussed, this text is going to be applicable to all Linux releases, and some are entirely command-line driven. We'll discuss some different types of shells, then take a look at *scripting*, or pre-written chunks of commands in a file meant to be ran by the computer at designated times.

## Basics

My favorite place to start- definitions. We consider a *terminal* to be any application that offers the user a text-based interaction with the computer. Most modern distros use terminal applications like Alacritty, kitty, and more. A step deeper, a *shell* is the interpreter running in the terminal application to handle input and output. 

Shell is built with the `sh` POSIX command, and the one most often used today or most well known is `bash`, or "Bourne Again Shell", named after the original Bourne shell. There are some modern shells but we'll take a look at that later.

How do shells control the flow of input and output? Through *streams*! The input stream collects user input, and the output stream sends that back. By default, your shell uses default File Descriptors (FD's) to handle where information goes. By default, your keyboard is `stdin`, or `FD 0`, and your monitor/terminal is where `stdout` (`FD 1`, standard output) or `stderr` (`FD 2`, standard error) are sent. I said default because you can actually control where these streams are sent and received from. 

*Redirecting* output is common enough to be pretty easy to do. For example, instead of putting errors out to the screen, you can send any error messages into a text file. These become known as *log* files, and help manage most applications. The syntax is `$FD>` or `<$FD`, where `$FD` is the number associated with each stream. To redirect the `stderr`
stream, we would use `2>`. `stdout` is default, so `1>` and `>` mean the same thing. You can redirect both `stdout` and `stderr` using `&>`, and can get rid of a stream using `/dev/null`;

```bash
$ curl https://www.mrpointing.com &> /dev/null
# Takes the output from the curl and directs it to a garbage space
$ curl https://www.mrpointing.com > content.txt 2> curl-status
# Redirects content and status to different files
$ cat > interactive-input.txt
# Allows you to start writing and saves input into the file given
```

This is just a preview of the power of shell scripting. There are some special characters you'll see used often;

- `&`: Used to run the given process in the background
- `\`: Used to continue a command onto a new line (mostly for readability)
- `|`: Used to send the output of one command into the input stream of another command

**Variables** are also possible when using the terminal. There are two we should be concerned with; *Environment* variables denoted with `env`, and *Shell* variables, which only exist in the context of the shell session you exist in. Let's see how to actually use these;

```bash
$ set cool_var=15 # Sets a shell variable called cool_var
$ set | grep cool_var # Lists all shell variables, but then pipes in a grep to only recieve results with 'cool_var'
_=cool_var=15
$ export global_cool_var="var fun time" # Make a new global variable
$ set | grep 'cool*' # Find results for variables we just made
_='global_cool_var=var fun time'
global_cool_var='var fun time'
$ env | grep 'cool*' # List global env variables
global_cool_var=var fun time
$ bash # Refresh the environment
$ echo $global_cool_var # Our global var is still there
var fun time
```

There are some pretty useful environment variables most shell environments will have (the text has a good amount, I just grabbed what I felt were the most important);

- `EDITOR`: Path to default editor
- `HOME`: Path to home directory
- `PATH`: Lists of directories where the shell looks for executable
- `PWD`: Full path to working directory

There are a good amount of built in commands; they can be listed by running `help`. You could also likely find other commands in the `/usr/bin` and `/usr/sbin` directories, for user and admin commands respectively;

```bash
$ which ls
/usr/bin/ls
```

You'll find that different commands you'll come across take full control of the terminal (say, updating packages). If you wanted that to happen in the background, you just have to end the line with an `&`. Then, you can use `jobs` to see which processes are running, and `fg` to bring it back to the foreground.

## Modern Commands

Some commands are going to be used all the time; `ls`, `cat`, `cd`. A few more, but these are good to start with. Since these commands have been around forever, people have updated and built on top of these to make even more useful commands.

This is a great example at the rate at which tech literature becomes obsolete. The first option presented (`exa`) already has another name to download it by (`eza`). Not a big or breaking change, but funny how modern books can still become dated. `eza` is essentially a better version of `ls`. 

`bat` is an updated version of `cat` that offers syntax highlighting, as well as a separate page view for long files. This one is new to me, and I;m excited to include it in my toolkit. Keeping in the same vein as similar titles for existing commands, `ripgrep` or simply `rg` is a faster version of `grep`, that allows for more complex searches. A simple example of this is searching for the word "search" in a directory. I have a directory called `hugo_scripts`, with a few files in it. To search for all the instances of 'search' in my directory, the best way I know to do it with grep is the following;

```bash
grep search main.py o_to_h.py path_files.py
main.py:def replace_text_in_content(content, search_text, replacement_text):
main.py:    return re.sub(search_text, replacement_text, content)
main.py:def process_directory(directory_path, search_text, replacement_text):
main.py:        new_content = replace_text_in_content(content, search_text, replacement_text)
main.py:    search_text = input("Enter the text to search for: ")
main.py:    process_directory(directory_path, search_text, replacement_text)
```
I have to list out all the files I'm searching in. If I had more than 3 files, I'd be annoyed at how long it took. Now, with `rg`, doing such is trivial;

```bash
$ rg search
rg search
README.md
6:Nothing fancy; start with `o_to_h.py` to search through your vault for all files where a `draft` property 

main.py
19:def replace_text_in_content(content, search_text, replacement_text):
20:    return re.sub(search_text, replacement_text, content)
23:def process_directory(directory_path, search_text, replacement_text):
30:        new_content = replace_text_in_content(content, search_text, replacement_text)
40:    search_text = input("Enter the text to search for: ")
43:    process_directory(directory_path, search_text, replacement_text)
```

So much easier, with more verbose information like the file it was found in, with the line it was found on.

## Common Tasks

Being able to navigate your terminal while using it is what separates hobbyists from professionals. Not that you need to be a master to accomplish daily tasks, but if you end up working mainly in your terminal, you're going to want to make your life as easy as possible and adopt some useful conventions. For one, most shells offer faster navigation using `Ctrl + (insert character)`. A full list can be found in the text, but here are some I use all the time;

- `Ctrl+a`: Move to start of the line
- `Ctrl+e`: Move to the end of a line
- `Ctrl+Left Arrow`: Move back one word
- `Ctrl+Right Arrow`: Move forward one word
- `Ctrl+l`: Clear screen

Not everyone can use Vim motions, or wants too. Not only that, but there are often times where you don't want to bother opening up a text editor at all. In this case, you can edit files entirely through the command line, like in the following example;

```bash
$ echo "First!" > something # You can use the echo command to redirect output into a file
$ echo "Second!" >> something # Double >> refers to append; needed, or else you'll write over 'First!'
$ sed 's/!/?/' something # Replaces all instances of '!' with '?' in 'something', but only in output. File remains unchanged. 
$ cat << 'EOF' > another 
First!
Second!
Third!
EOF
# The above is a cool command; we open a new file called 'another' and type into it until we pass in 'EOF'. 'EOF' is not saved into the file.
$ diff -y something another
First!								First!
Second!								Second!
							     >	Third!
```

Another useful command to leave you with; to easily get the date, you can use `date`;

```bash
$ date
Tue Jun 10 10:34:45 AM EDT 2025
```

## Modern Shells

Like we discussed with modern commands, there are also modern shells that replace the bash shell. While these are not *all* that different than just using bash, there are merits to at least know of a few of these (even if [YSAP](https://www.ysap.sh) says we should just use bash!)

The first we'll look at is the Fish shell. This one I've actually used before and can attest to the two additions being useful; execution history and auto-suggestions. Both are big QOL changes I thought were nice (even if I still just use bash). There is also a really easy config UI that I haven't used, but seems very easy to work with (call `fish_config` in a Fish shell).

Another one I've used and found to be quite nice is Z-shell, or `zsh`. Same thing as the last two, except it has an emphasis on line completions and theming support. There are some more that the text reviews, but to be honest, along with what I was mentioning earlier, I think deep diving into one of these now will do us a grave injustice given times change and change fast. For now, I'll stick to bash, and might make a move to another shell once I really feel confident in bash. 

### Terminal Multiplexer

This is a subheading I almost want to skip, but I'll get all the general information down. Personally, I find tabs in terminals to be a bit too much. I forget they're there, close a window, and lost 3 sessions. I would much rather have dedicated work spaces, and have a terminal in different spaces to separate them out. Not only that, but using window tiling makes it really easy to accomplish this. 

Let's say you're not like me- you enjoy having one screen and one workspace, and that's your jam. If so, this section is for you. We're going to look at ways to split your terminal window, primarily using `tmux`. The text does offer more, but actually explicitly recommends using `tmux`.

I took a small break to just configure and work with `tmux` and I gotta say, I'm slightly hooked. Mostly because figuring out how to configure it to look the way I want. Again, this is the multiplexer that the author recommends, so if you want to find others, a Google search will lead to a good list. The best resources I found on `tmux` were [this](file:///home/richie/Downloads/osdc_cheatsheet-tmux-2021.6.25.pdf) cheat sheet and [this](https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/) article on quick customization.

## Scripting

Of course, we should know how to navigate and remember useful commands that we'll use often. However, there are many times where you'll end up running the same commands over the same tasks over and over again. A task like this could warrant a *script*, or a chunk of pre-defined code within a file. For bash, these usually end in `.sh`.

While large scripts shouldn't be discouraged, it's worth considering using another language like Python to accomplish it. For the most part, bash is a good language to use due to it's accessibility. To walk through making a script, let's try to accomplish a task; print the following statement given a GitHub profile; `XXX XXX joined GitHub in YYYY`.

In addition to string date types (advanced numerical calculations should probably not be done using bash) there are arrays that are 0-indexed;

```bash
heroes = ('Link', 'Samus', 'Sora')
echo "${os[0]}" # Link
number_of_heroes = "${#heroes[@]}" # 3
```

Bash also has control structures like `if`, `for`, and `while`;

```bash
for afile in /tmp/* ; do
  echo "$afile"
done

for i in {1..10}; do
  echo "$i"
done

while true; do
  ...
done
```

We can even write functions;

```bash
say_hi() {
  echo "Hi $1 hope you are sick!"
}

say_hi "Sarah"
```

We can collect information from the user;

```bash
read name
printf "Hello %s" "$name"
```

For a full walk through of all the capabilities of bash scripting, there is a really nice cheat sheet [here](https://devhints.io/bash) that I thought was well put together. 

There's a term you might here often when referring to scripts, and that's a scripts *portability*. Not how easily you can literally pick it up and walk away; we're talking about the assumptions of the device you're running the script on. A highly portable script is one that doesn't rely on external dependencies, and can run on multiple systems without issue.

To actually begin writing a script, it's not as complex as you might think. Technically you can just use a text file, but there's a standard convention of ending any script in `.sh`. After that, you need two things; a declared interpreter on the first line (often called a *shebang*) and the permissions for that file to be executed (usually though `chmod +x`).

To help start you on your script writing journey, let's begin with a basic template. This will set you up for success while maintaining decent error handling;

```bash
#!/usr/bin/env bash # Our shebang, letting us know we want to interpret this script using bash

set -o errexit # script should end if any errors occur
set -o nounset # Unset variables are errors
set -o pipefail # If one portion of a pipe fails, it all fails

firstargument="${1:-somedefaultvalue}"

echo "$firstargument"
```

We use those three `set` commands to eliminate any silent errors; essentially, an error that won't break the program and let it continue functioning as if there was no error at all. This can lead to numerous issues, which we can circumnavigate easily with the previous example.

Let's review some good common practices;

- **Fail fast and loud**: errors should be caught and fail (the `set` commands we just went over)
- **Sensitive Information**: You should not have any sensitive info like a password or API key within a script
- **Input sanitization**: Default variables are essential to avoid outside, potentially dangerous input
- **Check dependencies**: Never want to assume a machine comes with something that isn't pre-installed or built-in; ex. using `curl` when a machine only has `wget` by default
- **Error handling**: Errors are to be expected; when they happen, provide clear indications to your users of what happened when and where
- **Documentation**: Just like any language, comments to help describe workflow are always encouraged
- **Version control**: Use Git!
- **Testing**: Lint and test!

If you ever want to look at your script and test for any errors, a great resource is [ShellCheck](https://www.shellcheck.net/), which not only has a browser version, but also one you can download locally as well.

Now that we know a decent amount about how to properly script, let's make that script for our GitHub account information;

```bash
#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

### Command line parameter:
targetuser="${1:-mr-pointing}"

### Check if dependencies are met:
if ! [ -x "$(command -v jq)" ]
then
    echo "jq is not installed :(" >&2
    exit 1
fi

### Main:
githubapi="https://api.github.com/users/"
tmpuserdump="/tmp/ghuserdump_$targetuser.json"

result=$(curl -s $githubapi$targetuser)
echo $result > $tmpuserdump

name=$(jq .name $tmpuserdump -r)
created_at=$(jq .created_at $tmpuserdump -r)

joinyear=$(echo $created_at | cut -f1 -d"-")
echo $name joined GitHub in $joinyear
```

### Chapter Resources

- [Book on `tmux`](https://leanpub.com/the-tao-of-tmux/read)
- [Deep dive into what the Terminal is](https://poor.dev/blog/terminal-anatomy/)
- [How streams actually work](https://lucasfcosta.com/2019/04/07/streams-introduction.html)
- [Style guide for shell scripts](https://google.github.io/styleguide/shellguide.html)
- [`bash` script cheat-sheet](https://devhints.io/bash)


---
Next: 
[Chapter 4]({{< ref "Learning Modern Linux - Chapter 4" >}}) 
