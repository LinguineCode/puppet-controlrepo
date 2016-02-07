# puppet-controlrepo

This project serves as a complete starter kit for your Puppet controlled infrastructure. It is an R10K-style "puppet-control" repository, set up with *Roles and Profiles* framework, and complete with a `Vagrantfile`.

## Installation and Usage

  1. Clone the repo
  1. Optionally: modify the values in [`common.yaml`](hieradata/common.yaml) to your heart's content (especially `puppet::master::r10k_remote`)
  1. `vagrant up`
  1. Enjoy!

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

Nov 2015: Initial commit


## Credits

[Sean S. King](https://github.com/seanscottking), author

Thanks to [Rob Nelson](http://rnelson0.com). His project [puppetinabox](https://github.com/puppetinabox) was the inspiration for this one.

Thanks to [Craig Dunn](www.craigdunn.org) and [Gary Larizza](http://garylarizza.com) for their broad research on ways to make Puppet not suck.


## License

[See LICENSE.md](LICENSE.md)