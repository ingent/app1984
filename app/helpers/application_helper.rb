# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def color_zebra(i)
    i.modulo(2)==0 ? 'clar' : 'fosc'
  end

  def data_i_hora(d)
    return "-" if d.nil?
    d.strftime("%d/%m/%Y %H:%M:%S")
  end

  def data(d)
    return "-" if d.nil?
    d.strftime("%d/%m/%Y")
  end

  def hora(d)
    return "-" if d.nil?
    d.strftime("%H:%M:%S")
  end

end
