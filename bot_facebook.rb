#!/usr/bin/env ruby

#bot Facebook qui va récupérer la liste de toutes les membres d'un groupe Facebook, avec nom et url
#fonctionne avec Facebook du 20171013

require 'watir'
require 'pry'


#url du groupe facebook a suivre : les francais de bogota
#page_url="https://www.facebook.com/groups/214718712053384/members"

class Facebook_scrap

	attr_accessor :browser

	def initialize(page_url)
		#on definit ici les valeurs par defaut a la creation de la class
		@page_url = page_url
		#on definit le navigateur a utiliser une bonne fois pour toute:
		@browser = Watir::Browser.new(:firefox)
	end

	#ne marchera pas, car en dehors d'un programme:
	#on va sur la page de groupes voulue , mais non loggué => il ft se logguer
	#@browser.goto @page_url

	#on definit une fonction qui se log sur facebook
	def log_in_to_facebook()
		#a tout hasard on propose d'aller sur la page
		@browser.goto "https://www.facebook.com/login/"

		#on rentre nos identifiants
		# => appel de nos identifiants caches qque part !! lol
		load '/home/brice/Documents/THP/S02J5/secret.rb'

		#et on les tape :
		@browser.text_field(id: 'email').set(Email_fb)
		@browser.text_field(id: 'pass').set(Pwd_fb)
		#et on clique :
		@browser.button(:id,"loginbutton").click
	end


end #fin de la class


page_url = "https://www.facebook.com/groups/214718712053384/members"
bot=Facebook_scrap.new(page_url)

bot.log_in_to_facebook()

