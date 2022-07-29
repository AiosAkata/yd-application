package com.koelsa.sw.util.excel;

import java.util.*;

public class ExcelRow implements Map<String, String> {
    List<String> keys = new ArrayList<String>();
    List<String> values = new ArrayList<String>();

    public int size() {
        return keys.size();
    }

    public boolean isEmpty() {
        return keys.size() == 0;
    }

    public boolean containsKey(Object key) {

        for (String aKey : keys) {
            if (aKey.equals(key))
                return true;
        }

        return false;
    }

    public boolean containsValue(Object value) {
        for (String aValue : values) {
            if (aValue.equals(value))
                return true;
        }

        return false;
    }

    public String get(Object key) {

        for (int i = 0; i < keys.size(); i++) {
            if (keys.get(i).equals(key))
                return values.get(i);
        }

        return null;
    }

    public String put(String key, String value) {

        keys.add(key);
        values.add(value);

        return key;
    }

    public String remove(Object key) {

        for (int i = 0; i < keys.size(); i++) {
            if (keys.get(i).equals(key)) {
                keys.remove(i);
                return values.remove(i);
            }
        }

        return null;
    }

    public void putAll(Map<? extends String, ? extends String> m) {

    }

    public void clear() {
        keys.clear();
        values.clear();
    }

    public Set<String> keySet() {
        return null;
    }

    public Collection<String> values() {
        return null;
    }

    public Set<Entry<String, String>> entrySet() {
        return null;
    }

    public List<String> getValues() {
        return values;
    }

    public List<String> getKeys() {
        return keys;
    }

    public void set(ExcelRow row) {
        this.keys = row.keys;
        this.values = row.values;
    }

    @Override
    public String toString() {
        String output = "";

        for (int i = 0; i < keys.size(); i++) {
            output += keys.get(i) + " : " + values.get(i) + "\t";
        }

        return output;
    }
}
