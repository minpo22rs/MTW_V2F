class TestStore {
  String leagueName;
  List<Club> listClubs;

  TestStore(this.leagueName, this.listClubs);
}

class Club {
  String clubName;
  List<Player> listPlayers;

  Club(this.clubName, this.listPlayers);
}

class Player {
  String playerName;

  Player(this.playerName);
}
