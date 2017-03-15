# Software I once wrote

Most of my software can be found on my [github
account](https://github.com/Tarrasch/).  I have hundreds of minor
contributions to various projects. This is because if something isn't working
in the software I use, I fix it and contribute back to the community as a
thanks for developing the software in the first place. For example, I've
submitted many patches to the [Yesod web framework on
github](https://github.com/yesodweb/yesod/commits?author=tarrasch).

Some of my repositories on github are actual projects with me as the main developer. Here are some favorites

  * [zsh-functional] - 2012, brings the common higher order functions to your shell. I
    use the functions from this library on a daily basis and it'll be
    appreciated by other functional programmers as well. It's simple and useful
    and that's why I love it!
  * [Hong] - 2011, is a pong clone written in haskell using the *functional reactive
    programming paragdigm*. This makes the code concise and
    [testable](https://github.com/Tarrasch/Hong/blob/master/test/HongTest.hs)
    in isolation. After showing this game to Know IT as part of their
    programming contest, they invited me to talk about the interesting
    technologies I used,
    [here](https://github.com/Tarrasch/Hong/raw/master/presentation/slide.odp)
    are the slides I used at my presentation. Know IT is one of scandinavias
    major IT consultants.
  * [DtekPortalen] - 2012, is the official student web site for the CSE department at
    Chalmers University. The site is written in haskell using the yesod web
    framework. The interesting aspects of the project is it's use of Type
    saftey on the web to deal with the [boundary
    issue](http://www.yesodweb.com/book/introduction).

[zsh-functional]: https://github.com/Tarrasch/zsh-functional
[Hong]: https://github.com/Tarrasch/Hong
[DtekPortalen]: https://github.com/dtekcth/DtekPortalen

## The Motion Grammar (2013)

During my year abroad at Georgia Tech (2012-2013) I joined the Humanoid
Robotics lab, [golems][golems]. I worked on a project called the [Motion
Grammar][mg], it uses a formal language approach to robot control. The idea is
to control the robot by "executing" a context-free grammar in real time. My
[contribution][mgk-contribution] to their [codebase][mgk] was an improved
parser. This required comparing the modern parsers and analyzing which parser
best withstands the demands of real time robot control. We produced a workshop
abstract that can be found in the publications section of this website.

To show that the parser generator works correctly, I generated two proof of
concept parsers. One running in [simulation][motion-serving] and one that I
uploaded to real [hardware][mg-lights].

[mg]: http://golems.org/projects/mg.html
[golems]: http://golems.org/projects/mg.html
[mgk]: https://github.com/golems/motion-grammar-kit/
[mgk-contribution]: https://github.com/golems/motion-grammar-kit/compare/master...ll-star
[motion-serving]: https://github.com/Tarrasch/motion-serving
[mg-lights]: https://github.com/Tarrasch/mg-lights

# Very old projects

Here are some projects I created before I started to use github. While these
projects might be poorly coded, they testify that my passion for programming
existed long before I started my university studies.

## Babuschka Engine (2008)

An AI for the old board game
[Babuschka](http://sites.google.com/site/babuschkaengine/Home).  To improve the
game play of my engine, I took a Machine Learning approach and let the computer
play millions of games against itself with different parameters to find the
optimal parameter configuration.  Back then I had no idea what Machine Learning
was though! Downloads are in the [project
page](http://sites.google.com/site/babuschkaengine/Home).


## LBA Image Creator (2007)

Tool for modifying the in-game images for the old adventure game Little Big
Adventure. The program includes both a GUI and an image processing module.
This was the first time I read a theoretical description of an algorithm,
implemented it, and then analyzed its
[results](http://forum.magicball.net/showpost.php?p=343748&postcount=30).
Check out the [project page](https://sites.google.com/site/miffoljud/)

## Car Game (2004)

A simple computer game which I created myself in Delphi 7 around the age of 13.
Here is a [screenshot](/images/Screenshot-BilSpel.png) of the game.
