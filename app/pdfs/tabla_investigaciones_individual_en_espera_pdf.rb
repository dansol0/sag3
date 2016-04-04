class TablaInvestigacionesIndividualEnEsperaPdf < Prawn::Document

 
 def initialize(proyects, view)
	  super(:margin => [15,15,15,15])
	  @proyects = proyects
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
  	 text "LISTA DE INVESTIGACIONES INDIVIDUAL EN ESPARA POR APROBACIÓN", size: 15, style: :bold, align: :center
    move_down 30
    #bounding_box([25, cursor - 0], :width => 300, :height => 65) do
    #move_down 10
    	#pan(500,:position =>:center)do
	    	text "Fecha de emisión: " + " " + Date.today.strftime("%d/%m/%Y"), :size => 10, style: :bold
		#end
		#transparent(0.5) { stroke_bounds }

    #end
 

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
				column(0).width = 300
				column(1).width = 120
				column(2).width = 80

				

				
			end

 end

 def item_header
 	["TITULO","INVESTIGADOR RESPONSABLE","ENTE FINANCIADOR","MONTO Bs."]

 end

  def item_rows
                  
  	@proyects.each.map do |proyect|

  	 [proyect.titulo, proyect.investigador_responsable, proyect.ente_financista, proyect.monto] 
  	end
  end

  def item_table_data
 	[item_header, *item_rows] 
  end
		  

  def footer
    text "© 2015 IDEC, Instituto de Desarrollo Experimental de la Construcción.", size: 8, style: :bold_italic, align: :center
  end
   


end