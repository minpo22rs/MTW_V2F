class ProductStore {
  int id;
  String images;
  String name;
  bool check;
  ProductStore({
    required this.id,
    required this.images,
    required this.name,
    required this.check,
  });
}

List<ProductStore> productStore = [
  ProductStore(images: 'images', name: 'name', id: 1, check: false),
  ProductStore(images: 'images', name: 'name', id: 2, check: false),
  ProductStore(images: 'images', name: 'name', id: 3, check: false),
  ProductStore(images: 'images', name: 'name', id: 4, check: false),
  ProductStore(images: 'images', name: 'name', id: 5, check: false),
  ProductStore(images: 'images', name: 'name', id: 6, check: false),
];

class League {
  String leagueName;
  List<Club> listClubs;

  League(this.leagueName, this.listClubs);
}

class Club {
  String clubName;
  List<Player> listPlayers;

  Club(this.clubName, this.listPlayers);
}

class Player {
  String playerName;
  int number;
  Player(
    this.playerName,
    this.number,
  );
}

List<League> data = <League>[
  League(
    'Premier League',
    <Club>[
      Club(
        'Liverpool',
        <Player>[
          Player('Virgil van Dijk', 12),
          Player('Mohamed Salah', 2),
          Player('Sadio Mané', 990),
        ],
      ),
      Club(
        'Manchester City',
        <Player>[
          Player('Kevin De Bruyne', 12),
          Player('Sergio Aguero', 12),
        ],
      ),
    ],
  ),
  League(
    'La Liga',
    <Club>[
      Club(
        'Real Madrid',
        <Player>[
          Player('Sergio Ramos', 12),
          Player('Karim Benzema', 12),
        ],
      ),
      Club(
        'Barcelona',
        <Player>[
          Player('Lionel Messi', 12),
        ],
      ),
    ],
  ),
  League(
    'Ligue One',
    <Club>[
      Club(
        'Paris Saint-Germain',
        <Player>[
          Player('Neymar Jr.', 12),
          Player('Kylian Mbappé', 12),
        ],
      ),
    ],
  ),
  League(
    'Bundeshliga',
    <Club>[
      Club(
        'Bayern Munich',
        <Player>[
          Player('Robert Lewandowski', 12),
          Player('Manuel Neuer', 12),
        ],
      ),
    ],
  ),
];
