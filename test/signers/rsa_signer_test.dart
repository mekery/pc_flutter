// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.test.paddings.rsa_signer_test;

import "package:pc_flutter/pointycastle.dart";

import "../test/signer_tests.dart";
import "../test/src/helpers.dart";
import "../test/src/null_secure_random.dart";

void main() {
  var modulus = BigInt.parse(
      "20620915813302906913761247666337410938401372343750709187749515126790853245302593205328533062154315527282056175455193812046134139935830222032257750866653461677566720508752544506266533943725970345491747964654489405936145559121373664620352701801574863309087932865304205561439525871868738640172656811470047745445089832193075388387376667722031640892525639171016297098395245887609359882693921643396724693523583076582208970794545581164952427577506035951122669158313095779596666008591745562008787129160302313244329988240795948461701615228062848622019620094307696506764461083870202605984497833670577046553861732258592935325691");
  var publicExponent = BigInt.parse("65537");
  var privateExponent = BigInt.parse(
      "11998058528661160053642124235359844880039079149364512302169225182946866898849176558365314596732660324493329967536772364327680348872134489319530228055102152992797567579226269544119435926913937183793755182388650533700918602627770886358900914370472445911502526145837923104029967812779021649252540542517598618021899291933220000807916271555680217608559770825469218984818060775562259820009637370696396889812317991880425127772801187664191059506258517954313903362361211485802288635947903604738301101038823790599295749578655834195416886345569976295245464597506584866355976650830539380175531900288933412328525689718517239330305");
  var p = BigInt.parse(
      "144173682842817587002196172066264549138375068078359231382946906898412792452632726597279520229873489736777248181678202636100459215718497240474064366927544074501134727745837254834206456400508719134610847814227274992298238973375146473350157304285346424982280927848339601514720098577525635486320547905945936448443");
  var q = BigInt.parse(
      "143028293421514654659358549214971921584534096938352096320458818956414890934365483375293202045679474764569937266017713262196941957149321696805368542065644090886347646782188634885321277533175667840285448510687854061424867903968633218073060468434469761149335255007464091258725753837522484082998329871306803923137");

  var pubk = new RSAPublicKey(modulus, publicExponent);
  var privk = new RSAPrivateKey(modulus, privateExponent, p, q);

  var pubParams = () => new ParametersWithRandom(
      new PublicKeyParameter<RSAPublicKey>(pubk), new NullSecureRandom());
  var privParams = () => new ParametersWithRandom(
      new PrivateKeyParameter<RSAPrivateKey>(privk), new NullSecureRandom());

  runSignerTests(new Signer("SHA-1/RSA"), privParams, pubParams, [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
    _newSignature(
        "18683e8e227a62049c4f249fcebb5a41dbdd03a926cbf5928be2cf81f870c5fab7865a9caec7b50291a8e3be0089ad86692b3e319060da928934a3"
        "1ee23b04867a4b5237f2bd66e2a42e1098db797303693cb435a0a6155f20ecc0bf8a6522a72a20ccbb6ae9f2e227a340cce213299f438cda9518fc"
        "fbfd63ed3b6d302f3248ee046bca9cc29fdeb64547b6639d24d4ea45361c98454ed413f0d0b96cdca62b74a193fcdf4ba7d9d6010bc01bd39f5c82"
        "37d62b9025458aa71729331ce41d996643adfb1631c9561d8959e423aefb3024bf987589930e2c5ae780517199bab1e13efa2d1642648ad405b489"
        "73e9ae0b4dea3943d91d7ab849b3935100e70dcd"),
    "En un lugar de La Mancha, de cuyo nombre no quiero acordarme...",
    _newSignature(
        "17716fff28fac619fefa4345042beb21217e34589b7bd3689b27acfad08ccd6ad4476f1e79cbcb3a239269c2de0e070b3e8179244db5cb2a5840da"
        "e372b174595992db96e6a007e5f2ffebaef9c7b7b0013f8ef6f4656986299b8e8459560185cfde06f77bcf82ec32d83694dd1a4e0b91f2e5e5a34a"
        "653e1d89e7e8b80b2935ea9a422670e567332d24bb1ed3ca0daf367c833b8113105204ad677be45aa3507e26f54e39e36edf6175c64302d05261a0"
        "bade75cdd93f4383ed224fe1b61b2f74d7c0bcbffe9908cfb58d48d848b062702541af610f7d21f318297d126757492fc48fb3a1c91c36ddf0b5dd"
        "971de9a857e390badb0766779eea5672097b695d"),
  ]);
}

RSASignature _newSignature(String value) =>
    new RSASignature(createUint8ListFromHexString(value));
