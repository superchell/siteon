import "init";

import "components/header/header";


import "components/homepage/homepage";
import "components/portfolio/portfolio";
import "components/page/page";
import "components/landings/landings";

import "components/footer/footer";
import "components/callback_form/callback_form";

// Support component names relative to this directory:
var componentRequireContext = require.context("components/react", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)