My dot files

---

Directory Structure:

- /usr/local
    - /src (third party repos for all users)
    - /bin (third party binaries for all users)
- ~/.local
    - /src (third party repos for current user)
    - /bin (third party binaries for current user)
- ~/bin (private current user binaries)


---

If created, `.custom_bash` file will be executed after `.bashrc`.
This file should contain all custom bash configuration such as path configurations for
particular apps running on the current server.
