package com.abacorp.aba.core.utils;

import lombok.experimental.UtilityClass;

import javax.servlet.http.HttpSession;

@UtilityClass
public class SessionUtils {

    public static boolean isEmpty(HttpSession session, String key) {
        Object obj = session.getAttribute(key);
        return obj == null;
    }

    public static Object getObjectValue(HttpSession session, String key) {
        if (isEmpty(session, key)) {
            return null;
        }

        return session.getAttribute(key);
    }
}
