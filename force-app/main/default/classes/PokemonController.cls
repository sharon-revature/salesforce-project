public with sharing class PokemonController {
    public String pokemonName { get; set; }
    public String pokemonImageUrl { get; private set; }
    
    public void getPokemon() {
        if (pokemonName != null) {
            pokemonImageUrl = getPokemonImage(pokemonName);
            
            // enqueue a Queueable job to update the running user's record
            if (pokemonImageUrl != null) {
                System.enqueueJob(new UpdateUserWithPokemonImage(pokemonImageUrl));
            }
        }
    }
    
    // Helper to call the Pokémon API and fetch the image URL
    public static String getPokemonImage(String name) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + name.toLowerCase());
            request.setMethod('GET');
            
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> sprites = (Map<String, Object>) results.get('sprites');
                return (String) sprites.get('front_default');
        } }
        catch (Exception e) {
            System.debug('Error fetching Pokémon: ' + e.getMessage());
        }
        return null;
    }
}