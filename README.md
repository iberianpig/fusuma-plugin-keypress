# Fusuma::Plugin::Keypress [![Gem Version](https://badge.fury.io/rb/fusuma-plugin-keypress.svg)](https://badge.fury.io/rb/fusuma-plugin-keypress) [![Build Status](https://travis-ci.com/iberianpig/fusuma-plugin-keypress.svg?branch=master)](https://travis-ci.com/iberianpig/fusuma-plugin-keypress)


Keypress combination plugin for [Fusuma](https://github.com/iberianpig/fusuma)

## Installation

Run the following code in your terminal.

### Install keypress

```
$ sudo apt-get install libinput-tools
```

### Install fusuma-plugin-keypress

This plugin requires [Fusuma](https://github.com/iberianpig/fusuma#update) version 1.0 or later.

```sh
$ gem install fusuma-plugin-keypress
```

## Properties

Add `keypress:` property in `~/.config/fusuma/config.yml`.

Currently, values following are available for `keypress`.
* `KEY_CAPSLOCK`
* `KEY_LEFTALT`
* `KEY_LEFTCTRL`
* `KEY_LEFTMETA`
* `KEY_LEFTSHIFT`
* `KEY_RIGHTALT`
* `KEY_RIGHTCTRL`
* `KEY_RIGHTSHIFT`
* `KEY_RIGHTSHIFT`

## Example

Set `keypress:` property and values under gesture in `~/.config/fusuma/config.yml`.

```yaml
swipe:
  4:
    up:
      command: 'xdotool key super+s'
      keypress:
        KEY_LEFTMETA:
          command: 'xdotool key XF86MonBrightnessUp'

    down:
      command: 'xdotool key super+a'
      keypress:
        KEY_LEFTMETA:
        command: 'xdotool key XF86MonBrightnessDown'
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iberianpig/fusuma-plugin-keypress. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fusuma::Plugin::Keypress project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/iberianpig/fusuma-plugin-keypress/blob/master/CODE_OF_CONDUCT.md).
