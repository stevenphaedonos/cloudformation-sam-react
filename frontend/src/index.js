import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./App";
import * as serviceWorker from "./serviceWorker";

import Amplify, { Auth } from "aws-amplify";
import { Authenticator, Greetings } from "aws-amplify-react";
import { BrowserRouter as Router } from "react-router-dom";

import { CssBaseline } from "@material-ui/core";
import {
  MuiThemeProvider,
  createMuiTheme,
  responsiveFontSizes,
} from "@material-ui/core/styles";
import blue from "@material-ui/core/colors/blue";

let theme = createMuiTheme({
  palette: {
    primary: blue,
  },
});
theme = responsiveFontSizes(theme);

Amplify.configure({
  Auth: {
    identityPoolId: process.env.REACT_APP_IDENTITY_POOL_ID,
    region: process.env.REACT_APP_REGION,
    userPoolId: process.env.REACT_APP_USER_POOL_ID,
    userPoolWebClientId: process.env.REACT_APP_USER_POOL_CLIENT,
  },
  API: {
    endpoints: [
      {
        name: "backend",
        endpoint: process.env.REACT_APP_BACKEND_URL,
        custom_header: async () => {
          try {
            return {
              Authorization: (await Auth.currentSession())
                .getIdToken()
                .getJwtToken(),
            };
          } catch (err) {
            console.log(err);
            return { Authorization: null };
          }
        },
      },
    ],
  },
});

ReactDOM.render(
  <MuiThemeProvider theme={theme}>
    <CssBaseline />

    <Router>
      <Authenticator hide={[Greetings]}>
        <App />
      </Authenticator>
    </Router>
  </MuiThemeProvider>,
  document.getElementById("root")
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
