# Fusuma::Plugin::Keypress [![Gem Version](https://badge.fury.io/rb/fusuma-plugin-keypress.svg)](https://badge.fury.io/rb/fusuma-plugin-keypress) [![Build Status](https://github.com/iberianpig/fusuma-plugin-keypress/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/iberianpig/fusuma-plugin-keypress/actions/workflows/ubuntu.yml)


Keyboard + Touchpad combination plugin for [Fusuma](https://github.com/iberianpig/fusuma)

* Customize gestures with modifier keys
* Supports multiple modifier key combinations

## Installation

Run the following code in your terminal.

### Install fusuma-plugin-keypress

This plugin requires [Fusuma](https://github.com/iberianpig/fusuma#update) version 1.4 or later.

```sh
$ sudo gem install fusuma-plugin-keypress
```

### Add show-keycodes option

Open `~/.config/fusuma/config.yml` and add the following code at the bottom.

```yaml
plugin:
  inputs:
    libinput_command_input:
      show-keycodes: true
```

**NOTE: fusuma can read your keyboard inputs if show-keycodes option is true**

## Properties

### Keypress
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
* `RIGHTMETA`

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

plugin:
  inputs:
    libinput_command_input:
      show-keycodes: true
```

* Swipe up/down with four fingers while keypress LEFTMETA key to change display brightnes .
* Swipe up/down with four fingers while keypress LEFTMETA and LEFTALT keys to change audio volume.
  - If you want to combine a gesture with two keys, combine modifier keys with `+`


## Typing Gesture

`typing:` is a trigger that fires when keys other than modifier keys are pressed. This trigger provides disable-while-typing similar to libinput and syndaemon.
If you are using a keyremapper such as xkeysnail and libinput's disable-while-typing does not work, try setting it.

It can be placed in the root of yaml and configured as a gesture.
The following is a configuration that uses xinput to turn off tapping for 0.6 seconds to avoid false touches.

```yaml
typing: # disable while typing
  command: |
    touchpad_id=$(xinput | grep Touchpad | grep -oE "id=[0-9]*" | cut -d"=" -f 2)
    xinput set-prop $touchpad_id "libinput Tapping Enabled" 0
    file=/tmp/typing_command_break
    touch "$file"
    sleep 0.6
    [ `find "$file" -mmin +0.01` ] && \
      xinput set-prop $touchpad_id "libinput Tapping Enabled" 1
  interval: 0.5
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iberianpig/fusuma-plugin-keypress. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fusuma::Plugin::Keypress project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/iberianpig/fusuma-plugin-keypress/blob/master/CODE_OF_CONDUCT.md).
