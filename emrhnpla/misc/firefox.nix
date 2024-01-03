{ config, lib, pkgs, usercfg, ... }:

{
  programs.firefox = {
    enable = true;
    package = usercfg.env.browser.pkg;
  };

  home.file = {
    ".mozilla/firefox/profiles.ini".source = (pkgs.formats.ini { }).generate "profiles.ini" {
      General.Version = 2;
      Profile0 = {
        IsRelative = 1;
        Name = "default";
        Path = usercfg.username;
      };
    };
    ".mozilla/firefox/${usercfg.username}/chrome/userChrome.css".text = ''
      #TabsToolbar {
        visibility: collapse !important;
      }

      .bookmark-item {
        font-weight: 400 !important;
        font-size: 13px !important;
      }
    '';
    ".mozilla/firefox/${usercfg.username}/chrome/userContent.css".text = ''
      @-moz-document url("about:home"), url("about:newtab") {
        #root div {
          background-color: #1e1e2e !important;
        }
        #root main {
          width: auto !important;
          height: auto !important;
        }

        .personalize-button {
          display: none !important;
        }

        .outer-wrapper {
          display: flex !important;
          padding-top: 0px !important;
        }

        .wordmark {
          display: none !important;
        }

        .logo {
          background-size: 90px !important;
          height: 90px !important;
          width: 90px !important;
          opacity: 0.7 !important;
          margin-bottom: 200px !important;
        }

        .search-inner-wrapper {
          display: none !important;
        }
      }
    '';
  };
}
