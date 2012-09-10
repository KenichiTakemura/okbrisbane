class OkController < ApplicationController

  protected

  MODELS = {:p_job => Job,
    :p_buy_and_sell => BuyAndSell,
    :p_well_being => WellBeing,
    :p_estate => Estate,
    :p_motor_vehicle => MotorVehicle,
    :p_business => Business,
    :p_accommodation => Accommodation,
    :p_law => Law, 
    :p_tax => Tax,
    :p_study => Study,
    :p_immig => Immigration,
    :p_yellowpage => BusinessClient,
    :p_sponsor => BusinessClient,
    :p_mypage => Mypage
  }
  
end
