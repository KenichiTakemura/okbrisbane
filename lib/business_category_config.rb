# -*- coding: utf-8 -*-
module BusinessCategoryConfig

  BusinessCategory = Common.new_orderd_hash
  order = 0
  BusinessCategory[:accommodation] = [order += 1,"Accommodation"]
  BusinessCategory[:adult] = [order += 1,"Adult"]
  BusinessCategory[:arts_entertainment] = [order += 1,"Arts_Entertainment"]
  BusinessCategory[:automotive] = [order += 1,"Automotive"]
  BusinessCategory[:domestic_services] = [order += 1,"Domestic_Services"]
  BusinessCategory[:education_learning] = [order += 1,"Education_Learning"]
  BusinessCategory[:event_organisation] = [order += 1,"Event_Organisation"]
  BusinessCategory[:financial_services] = [order += 1,"Financial_Services"]
  BusinessCategory[:food_beverages] = [order += 1,"Food_Beverages"]
  BusinessCategory[:government] = [order += 1,"Government"]
  BusinessCategory[:hair_beauty] = [order += 1,"Hair_Beauty"]
  BusinessCategory[:manufacturing_agriculture] = [order += 1,"Manufacturing_Agriculture"]
  BusinessCategory[:media_communication] = [order += 1,"Media_Communication"]
  BusinessCategory[:medical] = [order += 1,"Medical"]
  BusinessCategory[:pets] = [order += 1,"Pets"]
  BusinessCategory[:professional_services] = [order += 1,"Professional_Services"]
  BusinessCategory[:religion] = [order += 1,"Religion"]
  BusinessCategory[:restaurants] = [order += 1,"Restaurants"]
  BusinessCategory[:retail_shopping] = [order += 1,"Retail_Shopping"]
  BusinessCategory[:sports_recreation] = [order += 1,"Sports_Recreation"]
  BusinessCategory[:trades] = [order += 1,"Trades"]
  BusinessCategory[:travel_transport] = [order += 1,"Travel_Transport"]
  BusinessCategory[:utilities] = [order += 1,"Utilities"]

end
