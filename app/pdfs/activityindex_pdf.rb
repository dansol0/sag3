class ActivityindexPdf < Prawn::Document

 
 def initialize(activities, view)
	  super(:margin => [15,15,15,15])
	  @activities = activities
	   @view = view
	  #bounding_box([8, cursor - 8],:width => 565,:height => 745) do
		  logo
			move_down 25
		  header ''
			move_down 30
		  body    
			move_down 220	                  
		 # footer
		 # transparent(0.5){ stroke_bounds }
		#end
	    
	end

  def logo
    logopath =  "#{Rails.root}/app/assets/images/logo_pdf.jpg"
    image logopath, :width => 197, :height => 91
    move_down 10
  end

  def header (title=nil)
  	 text "ACTIVIDADES ACADÉMICO ADMINISTRATIVAS", size: 15, style: :bold, align: :center
    move_down 30
    bounding_box([25, cursor - 0], :width => 300, :height => 65) do
    	move_down 10
    	span(500,:position =>:center)do
	    	text "Lista de actividades académico administrativas ", style: :bold, :size => 12
	    	move_down 10
	    	text "Fecha de emisión: " + " " + Date.today.strftime("%d/%m/%Y"), :size => 10, style: :bold
		end
		transparent(0.5) { stroke_bounds }

    end
 

    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end

  def body
  		
		  text "LISTA DE ACTIVIDADES:", size: 13, style: :bold, :color =>"0000FF", align: :center
		 move_down 10 
		  table(item_table_data, :cell_style => { :size => 8}, :width => 560,  :position => :center) do
 				cells.padding = 4
				row(0).font_style= :bold
				row(0).size = 9
				columns(0..3).borders = [:right, :top, :left, :bottom]
				row_colors =["F0F0F0","FFFFFF"]
				self.row_colors = ["F0F0F0","FFFFFF"]
				column(0).width = 20
				column(1).width = 100
				column(2).width = 385
			end
end

 def item_header
 	["ID","TIPO","Nombre","FECHA INICIO"]

 end

  def item_rows
                  
  	@activities.each.map do |activity|
  	 [activity.id, activity.tipo, activity.nombre, activity.fecha_i] 
  	end
  end

  def item_table_data
 	[item_header, *item_rows] 
  end
		  

  def footer
    text "© 2015 IDEC, Instituto de Desarrollo Experimental de la Construcción.", size: 8, style: :bold_italic, align: :center
  end
   


end