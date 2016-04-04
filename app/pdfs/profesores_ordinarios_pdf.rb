class ProfesoresOrdinariosPdf < Prawn::Document

 
 def initialize(users, view)
	  super(:margin => [15,15,15,15])
	  @users = users
	   @view = view
	   @i = 0
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
  	 text "LISTA DE PROFESORES ORDINARIOS POR ÁREA", size: 15, style: :bold, align: :center
  	 text "DE INVESTIGACIÓN Y ESTATUS", size: 15, style: :bold, align: :center
    move_down 30
    bounding_box([25, cursor - 0], :width => 180, :height => 30) do
    	move_down 10
    	span(500,:position =>:center)do
	    	
	    	text "Fecha de emisión: " + " " + Date.today.strftime("%d/%m/%Y"), :size => 10, style: :bold
		end
		transparent(0.5) { stroke_bounds }

    end
 

    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end

  def body
  		
		  table(item_table_data, :cell_style => { :size => 8}, :width => 560,  :position => :center) do
 				cells.padding = 4
				row(0).font_style= :bold
				row(0).size = 9
				columns(0..5).borders = [:right, :top, :left, :bottom]
				row_colors =["F0F0F0","FFFFFF"]
				self.row_colors = ["F0F0F0","FFFFFF"]
				column(0).width = 30
				column(1).width = 230
				column(2).width = 150
				column(3).width = 150
				
				
				

				
			end

 end

 def item_header
 	["#","PROFESORES","UNIDAD/ÁREA","ESTATUS"]

 end

  def item_rows
                  
  	@users.each.map do |user |
  	 [@i=@i+1, user.nombre_apellido, user.area, user.estatus] 
  	end
  end

  def item_table_data
 	[item_header, *item_rows] 
  end
		  

  def footer
    text "© 2015 IDEC, Instituto de Desarrollo Experimental de la Construcción.", size: 8, style: :bold_italic, align: :center
  end
   


end