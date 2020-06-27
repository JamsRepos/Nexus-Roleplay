let current = 0;
			$(function( ) {
				window.addEventListener("message", function(event) {
					if(event.data.type == "enableui") {
						event.data.enable ? $("body").show( ) : $("body").hide( );
						
						if(event.data.enable) {
							$.post("http://core/refreshload")
							$(".loaded-characters").html(event.data.characters);
							$(".window-main").show( );
						} else {
							$(".window-main").hide( );
						}   
					}
				});
				/*Returns to previous page*/
				$(".return-char-load").on("click", function(){
					$(".window-commands-load").hide();
                    $(".window-rules-load").hide();
                    $(".window-charcreate-load").hide();
					$(".window-character-load").show();
					$(".character-rules").hide();
					$(".faction-rules").hide();
					$(".community-rules").hide();
					$(".window-charsload-load").hide();
				});


				/*Continues to next pages*/
				$(".continue").click(function( ) {
					$(".window-initial-load").hide();
					$(".window-character-load").show( ); 
			
				});
				 /*NEW CHARACTER*/
				 $(".new").on("click", function(){
                    $(".window-charcreate-load").show();
                    $(".window-character-load").hide();
				});
				//Loads users characters
				$(".load-chars").on("click", function(){
					$(".window-charsload-load").show();
					$(".window-character-load").hide();
					// $.post("http://core/refreshload")
				});

				/*Load the commands list*/
				$(".commands").on("click", function(){
					$(".window-character-load").hide();
					$(".window-commands-load").show();
				});
				/*Load the rules main*/
				$(".rules").on("click", function(){
					$(".window-character-load").hide();	
					$(".window-rules-load").show();
					$(".general-rules").show();
				});
				/*Load General Rules*/
				$(".general").on("click", function(){
					var itm = $(this);
					if(!itm.data("open")){
						$(".general-rules").show();
						$(".character-rules").hide();
						$(".faction-rules").hide();
						$(".community-rules").hide();
						itm.data("open", true)
					}
				});
				/*Load Character Rules*/
				$(".character").on("click", function(){
					var itm = $(this);
					if(!itm.data("open")){
						$(".character-rules").show();
                        $(".general-rules").hide();
						$(".faction-rules").hide();
						$(".community-rules").hide();
						itm.data("open", true)
					}else{
                        $(".faction-rules").hide();
                        $(".character-rules").hide();
                        $(".community-rules").hide();
                        $(".general-rules").show();
						itm.data("open", false)
					}
				});
				/*Load Faction Rules*/
				$(".faction").on("click", function(){
					var itm = $(this);
					if(!itm.data("open")){
						$(".faction-rules").show();
                        $(".general-rules").hide();
                        $(".general").data("open", "false");
						$(".character-rules").hide();
						$(".community-rules").hide();
						itm.data("open", true)
					}else{
                        $(".faction-rules").hide();
                        $(".character-rules").hide();
						$(".community-rules").hide();
                        $(".general-rules").show();
						itm.data("open", false)
					}
				});
				/*Load Community Rules*/
				$(".community").on("click", function(){
					var itm = $(this);
					if(!itm.data("open")){
						$(".community-rules").show();
                        $(".general-rules").hide();
                        $(".general").data("open", "false");
						$(".character-rules").hide();
						$(".faction-rules").hide();
						itm.data("open", true)
					}else{
                        $(".character-rules").hide();
                        $(".community-rules").hide();
                        $(".faction-rules").hide();
                        $(".general-rules").show();
						itm.data("open", false)
					}
				});


				$(".select").click(function() {
					var charOptionsDiv = $(this).parent();
					var charParent = charOptionsDiv.parent();
					var charId = parseInt(charParent.attr("id"));
					$.post("http://core/selectcharacter", JSON.stringify({id: charId}));
				});
				
				$(".delete-prompt").click(function( ) {
					var charOptionsDiv = $(this).parent();
					var charParent = charOptionsDiv.parent();
					var charId = charParent.attr("id");
					var charName= charParent.data("name");
					$(".char-delete-prompt-main").css("display", "flex");
					$(".char-delete-prompt-main").attr("id", charId)
					$(".char-delete-prompt").append("<h2>Are you sure you want to delete " + charName + " </h2>")
				});
				$(".close-item").on("click", function(){
					var charOptionsDiv = $(this).parent();
					var parent1 = charOptionsDiv.parent();
					var parent2 = parent1.parent();
					var firstChild = parent1.children().eq(0);
					var childsChild = firstChild.children();
					childsChild.remove();
					parent2.hide();
				});
				$(".delete-char").on("click", function(){
					var charOptionsDiv = $(this).parent();
					var parent1 = charOptionsDiv.parent();
					var parent2 = parent1.parent();
					var charId = parent2.attr("id");

					$.post("http://core/deletecharacter", JSON.stringify({id: charId}));
				});
				
				$("input, textarea").bind("cut copy paste", function(event) {
					event.preventDefault( ); 
				});

				$("form").submit(function(event) {
					event.preventDefault( );
					
					$(".window").css("display", "none");
					$(".register").css("display", "none");
					
					$.post("http://core/create", JSON.stringify({
						firstname: $("#firstname").val( ),
						lastname: $("#lastname").val( ),
						dob: $("#dob").val( ),
						gender: $("#gender").val( ),
					}));
				});
				
				$(".cancel").click(function( ) {
					$(".register").hide( );
					$(".window").show( );
				});
				
				// $(document).on("click", ".character", function( ) {
                //     current = parseInt($(this).attr("id"));
                //     $(".character").removeClass("white");
                //     $(this).addClass("white");
                // });
			});