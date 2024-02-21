package co.com.demoblaze.certification;

import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

public class DemoBlazeRunner {

    @Test
    void userGet(){
        Runner.path("classpath:co/com/demoblaze/certification").parallel(2);
    }
}