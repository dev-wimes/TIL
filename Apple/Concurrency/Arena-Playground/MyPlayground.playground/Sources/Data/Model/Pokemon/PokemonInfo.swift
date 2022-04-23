import Foundation

// MARK: - PokemonInfo
public struct PokemonInfo: Codable {
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
public struct PokemonInfoAbility: Codable {
  let isHidden: Bool
  let slot: Int
  let ability: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case isHidden = "is_hidden"
    case slot, ability
  }
}

// MARK: - Species
public struct PokemonInfoSpecies: Codable {
  let name: String
  let url: String
}

// MARK: - GameIndex
public struct PokemonInfoGameIndex: Codable {
  let gameIndex: Int
  let version: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case gameIndex = "game_index"
    case version
  }
}

// MARK: - HeldItem
public struct PokemonInfoHeldItem: Codable {
  let item: PokemonInfoSpecies
  let versionDetails: [PokemonInfoVersionDetail]
  
  enum CodingKeys: String, CodingKey {
    case item
    case versionDetails = "version_details"
  }
}

// MARK: - VersionDetail
public struct PokemonInfoVersionDetail: Codable {
  let rarity: Int
  let version: PokemonInfoSpecies
}

// MARK: - Move
public struct PokemonInfoMove: Codable {
  let move: PokemonInfoSpecies
  let versionGroupDetails: [PokemonInfoVersionGroupDetail]
  
  enum CodingKeys: String, CodingKey {
    case move
    case versionGroupDetails = "version_group_details"
  }
}

// MARK: - VersionGroupDetail
public struct PokemonInfoVersionGroupDetail: Codable {
  let levelLearnedAt: Int
  let versionGroup, moveLearnMethod: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case levelLearnedAt = "level_learned_at"
    case versionGroup = "version_group"
    case moveLearnMethod = "move_learn_method"
  }
}

// MARK: - Sprites
public struct PokemonInfoSprites: Codable {
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
public struct PokemonInfoOther: Codable {
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
public struct PokemonInfoVersions: Codable {
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
public struct PokemonInfoGenerationI: Codable {
  let redBlue, yellow: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case redBlue = "red-blue"
    case yellow
  }
}

// MARK: - GenerationIi
public struct PokemonInfoGenerationIi: Codable {
  let crystal, gold, silver: PokemonInfoDreamWorld
}

// MARK: - GenerationIii
public struct PokemonInfoGenerationIii: Codable {
  let emerald, fireredLeafgreen, rubySapphire: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case emerald
    case fireredLeafgreen = "firered-leafgreen"
    case rubySapphire = "ruby-sapphire"
  }
}

// MARK: - GenerationIv
public struct PokemonInfoGenerationIv: Codable {
  let diamondPearl, heartgoldSoulsilver, platinum: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case diamondPearl = "diamond-pearl"
    case heartgoldSoulsilver = "heartgold-soulsilver"
    case platinum
  }
}

// MARK: - GenerationV
public struct PokemonInfoGenerationV: Codable {
  let blackWhite: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case blackWhite = "black-white"
  }
}

// MARK: - GenerationVii
public struct PokemonInfoGenerationVii: Codable {
  let icons, ultraSunUltraMoon: PokemonInfoDreamWorld
  
  enum CodingKeys: String, CodingKey {
    case icons
    case ultraSunUltraMoon = "ultra-sun-ultra-moon"
  }
}

// MARK: - GenerationViii
public struct PokemonInfoGenerationViii: Codable {
  let icons: PokemonInfoDreamWorld
}

// MARK: - Stat
public struct PokemonInfoStat: Codable {
  let baseStat, effort: Int
  let stat: PokemonInfoSpecies
  
  enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case effort, stat
  }
}

// MARK: - TypeElement
public struct PokemonInfoTypeElement: Codable {
  let slot: Int
  let type: PokemonInfoSpecies
}
