import "init";

import { Application } from 'stimulus';
import { autoload } from 'stimulus/webpack-helpers';

const application = Application.start();
const controllers = require.context('../components', true, /\.js$/);
autoload(controllers,application);

import "components/header/header";

import "components/footer/footer";
import "components/callback_form/callback_form";