# Static Site Generator with Jade, Bourbon and Neat

### Dependencies

- [sass v3.3+](http://sass-lang.com/install)
- [node.js](https://nodejs.org/download/)
- [npm v2.0+](https://docs.npmjs.com/getting-started/installing-node)
- [gulp.js](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md)

### Includes

- [Jade](http://jade-lang.com): For easy and fast templating
- [Sass](http://sass-lang.com): CSS with superpowers with clean .sass syntax
- [Bourbon](http://bourbon.io): Best mixin library for Sass
- [Neat](http://neat.bourbon.io): Grid framework for Sass and Bourbon
- [Bitters](http://bitters.bourbon.io): Scafold styles, variables and structure for Bourbon
- [CoffeeScript](http://coffeescript.org): The new way to write your JavaScript
- [BrowserSync](http://www.browsersync.io): Time-saving synchronised browser testing
- [Gulp.js](http://gulpjs.com): Automate and enhance your workflow

### To get started

1. `git clone https://github.com/CosminAnca/static-io.git your-project-folder`
2. `cd your-project-folder`
3. `git remote set-url origin your-repo-url`
4. `npm install`
5. `gulp`

### Usage

#### Templates

Templates are build using Jade language and datas provided from flat json files.

Before creating a new `.jade` file make sure you create a new `.jade.json` file inside `src/data/` folder. The name of the json file should be the same as the name of the jade file you want the data to be pulled in.

If you have to create a complex structure with multiple subpages all you need to do is to create new folders inside `src/templates/` folder and put your new `.jade` files in. (E.g. `src/templates/subpage/subpage.jade`)

#### Styles

Each folder inside `src/sass` includes a README file to guide you through better structuring your Sass files.

Thanks to Bitters the project will include basic styling. If you need to change this you just have to go through the `.sass` files and make the modifications.

#### Scripts

You can write pieces of functionality with JavaScript.

Using `gulp-include` makes inclusion of files a breeze. Enables functionality similar to that of snockets / sprockets or other file insertion compilation tools.

### Contributing

For any problems you encounter with this code, please create a
[GitHub Issue](https://github.com/CosminAnca/static-io/issues)

Want to add a feature or to help improve the code? Open a
[Pull Request](https://github.com/CosminAnca/static-io/pulls)

Thank you!