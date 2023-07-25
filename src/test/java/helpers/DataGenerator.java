package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
    
    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@text.com";
        return email;
    }

    public static String getRandomUserName(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    public static String getRandomText() {
        Faker faker = new Faker();
        String text = faker.book() + " " + faker.address() + " " + faker.random().nextInt(0, 100);
        return text;
    }

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }

    public String getRandomUserName2(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

}
