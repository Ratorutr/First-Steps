--- STEAMODDED HEADER
--- MOD_NAME: FirstSteps
--- MOD_ID: FirstSteps
--- MOD_AUTHOR: [TESLA]
--- MOD_DESCRIPTION: My first attempt at Balatro modding
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: bada55
--- PREFIX: mvan
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas {
  -- Key for code to find it with
  key = "FSOmega",
  path = "FSOmega.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'Chiptune',
  loc_txt = {
    name = 'Chiptune',
    text = {
      "{C:chips}#1#{} Chips",
      "{C:inactive}(Adds {C:chips}#2#{C:inactive} Chips for every played hand)"
    }
  },
  config = { extra = { chips = 0, chip_gain = 5, money = 1 } },
  rarity = 1,
  atlas = 'FSOmega',
  pos = { x = 0, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain, card.ability.extra.money } }
  end,
      
  calc_dollar_bonus = function(self, card)
      local bonus = card.ability.extra.money
      if bonus > 0 then return bonus end
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
      }
    end

    if context.before and not context.blueprint then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain;
      return {
        message = 'Upgraded!',
        colour = G.C.CHIPS,
        card = card
      }
    end
  end
}

SMODS.Joker {
  key = 'Multifunction',
  loc_txt = {
    name = 'Multifunction',
    text = {
      "{C:mult}#1#{} Mult",
      "{C:inactive}(Adds {C:mult}#2#{C:inactive} Chips for every played hand)"
    }
  },
  config = { extra = { mult = -2, mult_gain = 1 } },
  rarity = 1,
  atlas = 'FSOmega',
  pos = { x = 1, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end

    if context.before and not context.blueprint then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return {
        message = 'Upgraded!',
        colour = G.C.MULT,
        card = card
      }
    end
  end
}