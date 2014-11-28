![Lebrijo.com logo](http://www.lebrijo.com/assets/logo.png)

# Base server = PostgreSQL + Ubuntu + Nginx

Supported by OpenSSH + Chef-solo + Supervisor

Based on Ubuntu 14.04 LTS and PostgreSQL 9.3

## Run the container

Download image and run a container

```
docker pull jlebrijo/base
docker run -d -p 2222:22 -i jlebrijo/base
```

Inject your SSH public key:

```
sshpass -p 'J3mw?$_6' ssh-copy-id -o "StrictHostKeyChecking no" -i ~/.ssh/id_rsa.pub root@surprize.me -p 2222
```

SSH access over the port 2222: `ssh root@localhost -p 2222`

## Security Warn

The root password is 'J3mw?$_6' by default. You need to change it ASAP if you use this container public on the Internet:

```
 echo 'root:xxxxxxxxxxxxxxx' | chpasswd
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/prun-ops/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

[MIT License](http://opensource.org/licenses/MIT). Made by [Lebrijo.com](http://lebrijo.com)

