## Managing Container Storage Using Podman
### Commands Covered
* `podman run with -v`: using the `--volume` or `-v` switch with `podman run` to add persistent storage to a container
* `podman volume`: create and manage container volumes
* `podman cp`: copy data from the local filesystem to a containerfilesystem, or vice versa
### Adding Persistent Storage to a Container Using a Shared Directory
Run three nginx containers, serving content from the ~/html directory. We're going to create a couple of test text files in the directory and try accessing them using curl.
1. Check for containers:
```bash
podman ps -a
```
2. Create our ~/html directory:
```bash
mkdir ~/html
```
3. Create a text file in our ~/html directory:
```bash
echo Testfile! > ~/html/test1.txt
```
4. Look for an nginx containerimage to use:
```bash
podman search nginx | more
```
Let's use `docker.io/library/nginx`.
5. Start three nginx containers, with the names `web1`, `web2` and `web3`. We will attach the `~/html` directory
6. Map `~/html` to  `/usr/share/nginx/html/ `directory in the container:
```bash
podman run -dt --name web1 -v ~/html:/usr/share/nginx/html/:z docker.io/library/nginx
```
> Note: You may notice that we used a lowercase `z` to enable SELinux instead of the uppercase Z we would normally use with a single container bind. This allows more than one container access to the shared `~/html` directory.
7. Start the othertwo nginx containers:
```bash
podman run -dt --name web2 -v ~/html:/usr/share/nginx/html/:z
docker.io/library/nginx
```
```bash
podman run -dt --name web3 -v ~/html:/usr/share/nginx/html/:z
docker.io/library/nginx
```
8. Let's check for containers again:
```bash
podman ps -a
```

9. Curl in our containers to see if we can access the `test1.txt `file via `nginx`:
```bash
podman exec web1 curl -s http://localhost:80/test1.txt
podman exec web2 curl -s http://localhost:80/test1.txt
podman exec web3 curl -s http://localhost:80/test1.txt
```
We can see the contents of our test1.txt file!
10. Create anothertext file called `text2.txt` in `~/html`:
```bash
echo A second testfile! > ~/html/test2.txt
```
11. Curl in our containers to see if we can access the `test2.txt` file via `nginx`:
```bash
podman exec web1 curl -s http://localhost:80/test2.txt
podman exec web2 curl -s http://localhost:80/test2.txt
podman exec web3 curl -s http://localhost:80/test2.txt
```
We can see the contents of our test2.txt file!