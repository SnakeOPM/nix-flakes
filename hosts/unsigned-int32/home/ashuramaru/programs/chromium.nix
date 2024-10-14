{ lib, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    extensions =
      let
        bpc-version = "3.8.8.0";
        bpc-src = pkgs.fetchurl {
          url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass-paywalls-chrome-clean-${bpc-version}.crx";
          sha256 = "sha256-4ARBjfEV09ExosnSG9C/Qzq5rDaqSEr9hwWLJQlB3CI=";
        };
      in
      [
        # necessity
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # PrivacyBadger
        { id = "nomnklagbgmgghhjidfhnoelnjfndfpd"; } # canvas blocker
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
        { id = "jinjaccalgkegednnccohejagnlnfdag"; } # violentmonkey

        { id = "lckanjgmijmafbedllaakclkaicjfmnk"; } # clearurls
        { id = "hkligngkgcpcolhcnkgccglchdafcnao"; } # web archives

        # devtools
        { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # react devtools
        { id = "lmhkpmbekcpmknklioeibfkpmmfibljd"; } # redux devtools
        { id = "nhdogjmejiglipccpnnnanhbledajbpd"; } # vuejs devtools
        { id = "ienfalfjdbdpebioblfackkekamfmbnh"; } # angular
        { id = "kmcfjchnmmaeeagadbhoofajiopoceel"; } # solidjs
        { id = "bhchdcejhohfmigjafbampogmaanbfkg"; } # user agent

        { id = "hkgfoiooedgoejojocmhlaklaeopbecg"; } # Picture in Picture
        { id = "hipekcciheckooncpjeljhnekcoolahp"; } # tabliss
        { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # stylus
        { id = "gcknhkkoolaabfmlnjonogaaifnjlfnp"; } # foxyproxy
        { id = "oboonakemofpalcgghocfoadofidjkkk"; } # keepassxc
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
        { id = "kbmfpngjjgdllneeigpgjifpgocmfgmb"; } # reddit enhancment
        { id = "dneaehbmnbhcippjikoajpoabadpodje"; } # old reddit
        { id = "cnojnbdhbhnkbcieeekonklommdnndci"; } # search by image
        { id = "aapbdbdomjkkjkaonfhkkikfgjllcleb"; } # google translate
        { id = "gebbhagfogifgggkldgodflihgfeippi"; } # youtubedislikes
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsor block
        { id = "hkgfoiooedgoejojocmhlaklaeopbecg"; } # picture in picture
        { id = "jgejdcdoeeabklepnkdbglgccjpdgpmf"; } # old twitter layout
        {
          id = "lkbebcjgcmobigpeffafkodonchffocl";
          version = bpc-version;
          crxPath = bpc-src;
        }
      ];
    package = pkgs.chromium;
    commandLineArgs = [
      # debug
      "--enable-logging=stderr"
      # webgpu
      "--ignore-gpu-blocklist"
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
      # wayland
      "--ozone-platform-hint=auto"
      "--enable-wayland-ime"
      "--wayland-text-input-version=3"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
  };
  home.packages = [
    pkgs.google-chrome
    pkgs.microsoft-edge
  ];
}
