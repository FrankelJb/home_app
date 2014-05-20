# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	numbers_to_letters = {0: 'o', 1: 'i', 2: 'z', 3: 'e', 4: 'a', 5: 's', 7: 't', 8: 'b', 9: 'g'}
	letters_to_numbers = {'o': 0, 'i': 1, 'z': 2, 'e': 3, 'a': 4, 's': 5, 't': 7, 'b': 8, 'g': 9}
	common_substitutions_backward = {'!': 'i', '@': 'a', '#': 'e', '$': 's', '*': 'x'}
	common_substitutions_forward = {'i': '!', 1: '!', 'a': '@', 'e': '#', 3: '#', 's': '$', '5': '$', 'x': '*'}
	
	$('#password_numbers_for_letters').click ->
		word = $('#password_input').val()
		if !$('#password_expires_in_three_months').is(':checked')
			if $('#password_numbers_for_letters').is(':checked')
				for key, value of letters_to_numbers
					re = new RegExp(key, "g")
					word = word.replace(re, value)
			else
				for key, value of numbers_to_letters
					re = new RegExp(key, "g")
					word = word.replace(re, value)
			$('#password_input').val(word)
		else
			if $('#password_expires_in_three_months_inner_label').text().length == 13
				$('#password_expires_in_three_months_inner_label').append('<span id="alert-text">Date will become letters</span>')
	
	$('#password_common_substitutions').click ->
		word = $('#password_input').val()
		if !$('#password_expires_in_three_months').is(':checked')
			if $('#password_common_substitutions').is(':checked')
				for key, value of common_substitutions_forward
					if key == '$'
						word = word.split(key).join(value)
					else
						re = new RegExp(key, "g")
						word = word.replace(re, value)
			else
				for key, value of common_substitutions_backward
					if key == '$' || key == '*'
						word = word.split(key).join(value)
					else
						re = new RegExp(key, "g")
						word = word.replace(re, value)
			$('#password_input').val(word)
		else
			if $('#password_expires_in_three_months_inner_label').text().length == 13
				$('#password_expires_in_three_months_inner_label').append('<span id="alert-text">Date will become characters</span>')
			
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
			$('#alert-text').remove()
			$('#password_input').val($('#password_input').val().
															 substring(0,	$('#password_input').val().length - 6))
		else
			current_date = new Date()
			current_date.setMonth(current_date.getMonth() + 3)
			$('#password_input').val($('#password_input').val() + ("0" + (current_date.getMonth() + 1)).slice(-2) + current_date.getFullYear())


		