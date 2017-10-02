What params hash looks like when form to create a new LANDMARK is submitted:

params = {
  "landmark" => {
    "name" => "@name attribute value of landmark instance",
    "year_completed" => "@year_completed attribute value of landmark instance"
  }
}

Explanation:
* The "landmark" top-level key in params hash points to (and stores) the hash containing info about a landmark instance that I'll create. Refer to this hash as the landmark hash
* The "name" key of the landmark hash, which is nested inside of params hash, points to the @name attribute value of the landmark instance
* The "year_completed" key of the landmark hash points to the @year_completed attribute value of the landmark instance
-----------------
What params hash looks like when form to create a new FIGURE is submitted:

params = {
  "figure" => {
    "name" => "@name attribute value of figure instance",
    "title_ids" => [array of @id attribute values of title instances belonging to figure instance],
    "landmark_ids" => [array of @id values of landmark instances belonging to figure instance]
  },
  "landmark" => {
    "name" => "@name attribute value of new landmark created to belong to figure",
    "year_completed" => @year_completed attribute value of new landmark for figure"
  },
  "title" => {"name" => @name attribute value of new title created to belong to figure}
}

Explanation:
* The "figure" top-level key of params hash points to (and stores) the hash containing info about the new figure the user is creating in the form (the new figure instance I create). Refer to this hash as the figure hash
* The "name" key in the figure hash (nested inside the params hash) points to whatever the user enters into the form field <input> with name property = "figure[name]"
(i.e. @name attribute value of figure instance)
* Note: when the user checks a checkbox to indicate that an EXISTING title instance or an EXISTING landmark instance belongs to the figure instance, the value of the value property of the checkbox <input> = @id attribute value of the existing title instance or landmark instance, which gets passed through to params hash when the form is submitted, so...
* The "title_ids" key of the figure hash points to an array of @id attribute values of existing title instances (already saved to DB) that belong to the figure instance
* The "landmark_ids" key of the figure hash points to an array of @id attribute values of existing landmark instances (already saved to DB) that belong to the figure instance
* Since the user simultaneously has the option of creating a NEW landmark instance and/or a NEW title instance to belong to the figure instance when the new figure is created...
* The "landmark" top-level key of params hash points to (and stores) the landmark hash containing
2 key/value pairs of @name and @year_completed attribute data for the NEW landmark instance that we create to belong to the figure instance. @name attribute = whatever the user enters in form field to name the new landmark given to the figure. @year_completed attribute = whatever the user enters in form field for the landmark's year of completion
* The "title" top-level key of params hash points to (and stores) the title hash containing
1 key/value pair of @name attribute data for the NEW title instance that we create to belong to the figure instance. @name attribute = whatever the user enters in form field to name the new title given to the figure
