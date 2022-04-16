import Foundation

// MARK: - PokemonInfo
struct PokemonInfo: Codable {
  let id: Int
  let name: String
  let baseExperience, height: Int
  let isDefault: Bool
  let order, weight: Int
  let abilities: [PokemonInfoAbility]
  let forms: [PokemonInfoSpecies]
  let gameIndices: [PokemonInfoGameIndex]
  let heldItems: [PokemonInfoHeldItem]
  let locationAreaEncounters: String
  let moves: [PokemonInfoMove]
  let species: PokemonInfoSpecies
  let sprites: PokemonInfoSprites
  let stats: [PokemonInfoStat]
  let types: [PokemonInfoTypeElement]
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case baseExperience = "base_experience"
    case height
    case isDefault = "is_default"
    case order, weight, abilities, forms
    case gameIndices = "game_indices"
    case heldItems = "held_items"
    case locationAreaEncounters = "location_area_encounters"
    case moves, species, sprites, stats, types
  }
}

// MARK: - Ability
struct PokemonInfoAbility: Codable {
  let isHidden: Bool
  let slot: Int
  let ability: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case isHidden = "is_hidden"
    case slot, ability
  }
}

// MARK: - Species
struct PokemonInfoSpecies: Codable {
  let name: String
  let url: String
}

// MARK: - GameIndex
struct PokemonInfoGameIndex: Codable {
  let gameIndex: Int
  let version: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case gameIndex = "game_index"
    case version
  }
}

// MARK: - HeldItem
struct PokemonInfoHeldItem: Codable {
  let item: PokemonInfoSpecies
  let versionDetails: [PokemonInfoVersionDetail]
  
  enum CodingKeys: String, CodingKey {
    case item
    case versionDetails = "version_details"
  }
}

// MARK: - VersionDetail
struct PokemonInfoVersionDetail: Codable {
  let rarity: Int
  let version: PokemonInfoSpecies
}

// MARK: - Move
struct PokemonInfoMove: Codable {
  let move: PokemonInfoSpecies
  let versionGroupDetails: [PokemonInfoVersionGroupDetail]
  
  enum CodingKeys: String, CodingKey {
    case move
    case versionGroupDetails = "version_group_details"
  }
}

// MARK: - VersionGroupDetail
struct PokemonInfoVersionGroupDetail: Codable {
  let levelLearnedAt: Int
  let versionGroup, moveLearnMethod: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case levelLearnedAt = "level_learned_at"
    case versionGroup = "version_group"
    case moveLearnMethod = "move_learn_method"
  }
}

// MARK: - Sprites
struct PokemonInfoSprites: Codable {
  let frontDefault, frontShinyFemale, backShiny, frontShiny: String?
  let backFemale, backShinyFemale, backDefault, frontFemale: String?
  let other: PokemonInfoOther
  let versions: PokemonInfoVersions
  
  enum CodingKeys: String, CodingKey {
    case backFemale = "back_female"
    case backShinyFemale = "back_shiny_female"
    case backDefault = "back_default"
    case frontFemale = "front_female"
    case frontShinyFemale = "front_shiny_female"
    case backShiny = "back_shiny"
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
    case other, versions
  }
}

// https://stackoverflow.com/questions/27292255/how-to-loop-over-struct-properties-in-swift
extension PokemonInfoSprites{
  var allImageURLs: [String]{
    var result = [String]()
    
    let mirror = Mirror(reflecting: self)
    
    for (key, value) in mirror.children{
      guard
        let key = key,
        let value = value as? String,
        !(key == "other" || key == "versions")
      else{
        continue
      }
      result.append(value)
    }
    
    return result
  }
}

// MARK: - Other
struct PokemonInfoOther: Codable {
  let dreamWorld, officialArtwork: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case dreamWorld = "dream_world"
    case officialArtwork = "official-artwork"
  }
}

// MARK: - DreamWorld
struct PokemonInfoDreamWorld: Codable {
}

// MARK: - Versions
struct PokemonInfoVersions: Codable {
  let generationI: PokemonInfoGenerationI
  let generationIi: PokemonInfoGenerationIi
  let generationIii: PokemonInfoGenerationIii
  let generationIv: PokemonInfoGenerationIv
  let generationV: PokemonInfoGenerationV
  let generationVi: [String: PokemonInfoDreamWorld]
  let generationVii: PokemonInfoGenerationVii
  let generationViii: PokemonInfoGenerationViii
  
  enum CodingKeys: String, CodingKey {
    case generationI = "generation-i"
    case generationIi = "generation-ii"
    case generationIii = "generation-iii"
    case generationIv = "generation-iv"
    case generationV = "generation-v"
    case generationVi = "generation-vi"
    case generationVii = "generation-vii"
    case generationViii = "generation-viii"
  }
}

// MARK: - GenerationI
struct PokemonInfoGenerationI: Codable {
  let redBlue, yellow: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case redBlue = "red-blue"
    case yellow
  }
}

// MARK: - GenerationIi
struct PokemonInfoGenerationIi: Codable {
  let crystal, gold, silver: PokemonInfoDreamWorld
}

// MARK: - GenerationIii
struct PokemonInfoGenerationIii: Codable {
  let emerald, fireredLeafgreen, rubySapphire: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case emerald
    case fireredLeafgreen = "firered-leafgreen"
    case rubySapphire = "ruby-sapphire"
  }
}

// MARK: - GenerationIv
struct PokemonInfoGenerationIv: Codable {
  let diamondPearl, heartgoldSoulsilver, platinum: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case diamondPearl = "diamond-pearl"
    case heartgoldSoulsilver = "heartgold-soulsilver"
    case platinum
  }
}

// MARK: - GenerationV
struct PokemonInfoGenerationV: Codable {
  let blackWhite: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case blackWhite = "black-white"
  }
}

// MARK: - GenerationVii
struct PokemonInfoGenerationVii: Codable {
  let icons, ultraSunUltraMoon: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case icons
    case ultraSunUltraMoon = "ultra-sun-ultra-moon"
  }
}

// MARK: - GenerationViii
struct PokemonInfoGenerationViii: Codable {
  let icons: PokemonInfoDreamWorld
}

// MARK: - Stat
struct PokemonInfoStat: Codable {
  let baseStat, effort: Int
  let stat: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case effort, stat
  }
}

// MARK: - TypeElement
struct PokemonInfoTypeElement: Codable {
  let slot: Int
  let type: PokemonInfoSpecies
}
