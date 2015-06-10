# Bernietar

A simple app allowing you to show support for Bernie Sanders through your social media profile images.

## Public Repo

It should be obvious that this is a public repo. Therefore, `/config/secrets.yml` makes heavy use of environment
variables and you won't be able to clone this and start it up without setting those up in your local environment.

## Testing OAuth In Development

This can be a little rough. Facebook seems to especially picky. You can't use 127.0.0.1 or localhost. Let's assume your
production site is going to live at *example.com*. It's easiest if you add a host entry to your `/etc/hosts` file:
 
 ```
 127.0.0.1  local.example.com
 ```
 
 Facebook will allow you to use a subdomain as an **App Domain** so the above should work. You should be able to locally
 test your site at `http://local.example.com:3000`