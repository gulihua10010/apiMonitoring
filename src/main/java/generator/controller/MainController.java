package generator.controller;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author gulihua
 * @Description
 * @date 2024-04-25 14:19
 */
@RestController()
public class MainController {

    @GetMapping("/test")
    public String test() {

        return "ok";

    }
    @GetMapping("/test1")
    public String test1() {

        return "ok";

    }
}
