# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	replacements_backward = {0: 'o', 1: 'i', 2: 'z', 3: 'e', 4: 'a', 5: 's', 7: 't', 8: 'b', 9: 'g'}
	replacements_forward = {'o': 0, 'i': 1, 'z': 2, 'e': 3, 'a': 4, 's': 5, 't': 7, 'b': 8, 'g': 9}
	
	$('#password_numbers_for_letters').click ->
		word = $('#password_input').val()
		if !$('#password_expires_in_three_months').is(':checked')
			if $('#password_numbers_for_letters').is(':checked')
				for key, value of replacements_forward
					re = new RegExp(key, "g")
					word = word.replace(re, value)
			else
				for key, value of replacements_backward
					re = new RegExp(key, "g")
					word = word.replace(re, value)
			$('#password_input').val(word)
		else
			if $('#password_expires_in_three_months_inner_label').text().length == 13
				$('#password_expires_in_three_months_inner_label').append('<span id="alert-text">Date may become numbers</span>')
			
	$('#password_camel_case').click ->
		word = $('#password_input').val()
		if !$('#password_camel_case').is(':checked')
			$('#password_input').val(word.toLowerCase())
		else
			indices = $('#indices').text().split(',')
			new_word = ''
			index = 0
			for c in [0...word.length]
				if c == parseInt(indices[index])
					new_word += word.charAt(c).toUpperCase()
					c++
					index++
					continue
				new_word += word.charAt(c)
			$('#password_input').val(new_word)

	$('#password_keep_spaces').click ->
		word = $('#password_input').val()
		if $('#password_keep_spaces').is(':checked')
			indices = $('#indices').text().split(',')
			indices.splice(0, 1)
			characters = word.split('')
			new_word = ''
			count = 0
			index = 0
			while count < characters.length
				if count == parseInt(indices[index])
					new_word += ' '
					index++
				new_word += characters[count]
				count++
			$('#password_input').val(new_word)
			for i in [0...indices.length]
			 	indices[i] = parseInt(indices[i]) + 1 + i
			$('#indices').html("0," + indices)
		else
			$('#password_input').val($('#password_input').val().replace(/\s+/g, ''))
			indices = $('#indices').text().split(',')
			indices.splice(0, 1)
			for i in [0...indices.length]
			 	indices[i] = parseInt(indices[i]) - (1 + i)
			$('#indices').html("0," + indices)

	$('#password_expires_in_three_months').click ->
		if !$('#password_expires_in_three_months').is(':checked')
			console.log($('#alert-text').remove())
			$('#password_input').val($('#password_input').val().
															 substring(0,	$('#password_input').val().length - 6))
		else
			current_date = new Date()
			current_date.setMonth(current_date.getMonth() + 3)
			$('#password_input').val($('#password_input').val() + ("0" + (current_date.getMonth() + 1)).slice(-2) + current_date.getFullYear())


		