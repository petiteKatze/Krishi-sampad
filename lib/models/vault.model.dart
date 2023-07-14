class Vault {
  String vaultId;
  List<Map<String, VaultItem>>? vaultContent;
  int? vaultTotalPrice;
  int vaultTargetPrice;
  Vault(
      {required this.vaultId,
      this.vaultContent,
      required this.vaultTargetPrice,
      this.vaultTotalPrice});
}

enum Commodities {
  frenchBeansFrasbean,
  cabbage,
  gingerDry,
  tomato,
  peasDry,
  raddish,
  bhindiLadiesFinger,
  marigoldLoose,
  guava,
  mousambiSweetLime,
  capsicum,
  onion,
  chillyCapsicum,
  snakeguard,
  garlic,
  bittergourd,
  arharDalTurDal,
  sugar,
  mustard,
  paddyDhanCommon,
  blackGramDalUrdDal,
  greenChilli,
  cauliflower,
  roseLocal,
  squashChappalKadoo,
  lentilMasurWhole,
  fish,
  beans,
  banana,
  sweetPumpkin,
  mustardOil,
  pointedgourdParval,
  gingerGreen,
  carrot,
  sesamumSesameGingellyTil,
  bengalGramGramWhole,
  cucumbarKheera,
  ridgeguardTori,
  papayaRaw,
  masurDal,
  gurJaggery,
  moathDal,
  jute,
  mango,
  bottlegourd,
  apple,
  bengalGramDalChanaDal,
  potato,
  groundnut,
  pumpkin,
  wheat,
  rice,
  pomegranate,
  brinjal,
  greenGramDalMoongDal,
  arharTurRedGramWhole,
  betalLeaves,
  turmeric,
}

class VaultItem {
  Commodities itemType;
  int price;

  VaultItem({required this.itemType, required this.price});
}
