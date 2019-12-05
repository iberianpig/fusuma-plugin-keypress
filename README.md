# Fusuma::Plugin::Keypress [![Gem Version](https://badge.fury.io/rb/fusuma-plugin-keypress.svg)](https://badge.fury.io/rb/fusuma-plugin-keypress) [![Build Status](https://travis-ci.com/iberianpig/fusuma-plugin-keypress.svg?branch=master)](https://travis-ci.com/iberianpig/fusuma-plugin-keypress)


Keypress combination plugin for [Fusuma](https://github.com/iberianpig/fusuma)

* Customize gestures with modifier keys
* Supports multiple modifier key combinations

## Installation

Run the following code in your terminal.

### Install libinput-tools

```sh
$ sudo apt-get install libinput-tools
```

### Install fusuma-plugin-keypress

This plugin requires [Fusuma](https://github.com/iberianpig/fusuma#update) version 1.3 or later.

```sh
$ gem install fusuma-plugin-keypress
```

### Add show-keycode option

Modify ~/.config/fusuma following

```yaml
plugin: 
  inputs:
    libinput_command_input:
      show-keycode: true
```

**NOTE: fusuma can read your keyboard inputs if show-keycode option is true** 

## Properties

Add `keypress:` property in `~/.config/fusuma/config.yml`.

Keys following are available for `keypress`.
* `CAPSLOCK`
* `LEFTALT`
* `LEFTCTRL`
* `LEFTMETA`
* `LEFTSHIFT`
* `RIGHTALT`
* `RIGHTCTRL`
* `RIGHTSHIFT`

## Example

Set `keypress:` property and values under gesture in `~/.config/fusuma/config.yml`.

```yaml
swipe:
  4:
    up:
      command: 'xdotool key super+s'
      keypress:
        LEFTMETA:
          command: 'xdotool key --clearmodifiers XF86MonBrightnessUp'
        LEFTMETA+LEFTALT:
          command: 'xdotool key --clearmodifiers XF86AudioRaiseVolume'

    down:
      command: 'xdotool key super+a'
      keypress:
        LEFTMETA:
          command: 'xdotool key --clearmodifiers XF86MonBrightnessDown'
        LEFTMETA+LEFTALT:
          command: 'xdotool key --clearmodifiers XF86AudioLowerVolume'
```

* Swipe up/down with four fingers while keypress LEFTMETA key to change display brightnes .
* Swipe up/down with four fingers while keypress LEFTMETA and LEFTALT keys to change audio volume.
  - If you want to combine a gesture with two keys, combine modifier keys with `+` 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iberianpig/fusuma-plugin-keypress. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fusuma::Plugin::Keypress project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/iberianpig/fusuma-plugin-keypress/blob/master/CODE_OF_CONDUCT.md).
