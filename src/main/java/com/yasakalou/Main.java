package com.yasakalou;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        /**
         * 1. Удаление узлов дерева:
         *    1.1. Удалить узлы Procedure и Function, у которых нету дочерних элементов.
         */
        transformation(PathConstants.DATA_XML, PathConstants.TASK_1_1, PathConstants.OUTPUT_1_1);

        /**
         * 1. Удаление узлов дерева:
         *    1.2. Удалить все ПУСТЫЕ атрибуты java_package из всех узлов дерева.
         */
        transformation(PathConstants.OUTPUT_1_1, PathConstants.TASK_1_2, PathConstants.OUTPUT_1_2);

        /**
         * 2. Во всех узлах дерева, в которых атрибута target_type ПУСТАЯ - нужно добавить з начение "UNKNOWN" в эту же атрибуту:
         *    Пример: <Function ID="11" ... target_type="UNKNOWN" .../>
         */
        transformation(PathConstants.DATA_XML, PathConstants.TASK_2, PathConstants.OUTPUT_2);

        /**
         * 3. Выполнить выборку узлов Procedure и Function, в которых атрибута Name повторяется, чтобы в результате получилось дерево следующего вида:
         *    <root>
         *       <Functions>
         *          <!-- Список из функций с одинаковыми именами -->
         *          <Function ...>
         *             ...
         *          </Function>
         *       </Functions>
         *       <Procedures>
         *          <!-- Список из процедур с одинаковыми именами -->
         *          <Procedure ...>
         *             ...
         *          </Procedure>
         *       </Procedures>
         *    </root>
         */
        transformation(PathConstants.DATA_XML, PathConstants.TASK_3, PathConstants.OUTPUT_3);

        /**
         * 4. Выполнить выборку узлов Object, в которых атрибута ID является чётной, так же эти узлы Object необходимо отсортировать по возрастанию (значение атрибуты ID), чтобы в результате получилось дерево следующего вида:
         *    <Objects>
         *       <Object ID="8" ...>
         *          ...
         *       </Object>
         *       <Object ID="10" ...>
         *          ...
         *       </Object>
         *       ...
         *    </Objects>
         */
        transformation(PathConstants.DATA_XML, PathConstants.TASK_4, PathConstants.OUTPUT_4);

        /**
         * 5. Для каждого узла Param, у которого атрибута Name повторяется с другими узлами Param, то необходимо объединить значения атрибут Name и pos:
         *    Примеры: <Param ID="3" Name="p_LOGIN_ID1" pos="1" .../>
         *             <Param ID="4" Name="p_UPDATE_DATE2" pos="2" .../>
         */
        transformation(PathConstants.DATA_XML, PathConstants.TASK_5, PathConstants.OUTPUT_5);
    }

    /**
     * Метод для трансформации xml
     *
     * @param xmlInputPath - путь к входному файлу
     * @param xsltFilePath - путь к файлу трансформации
     * @param outputPath - путь к файлу вывода
     */
    private static void transformation(String xmlInputPath, String xsltFilePath, String outputPath){
        try {

            // Создаем фабрику трансформеров
            //TransformerFactory transformerFactory = TransformerFactory.newInstance();
            TransformerFactory transformerFactory = TransformerFactory.newInstance("com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl", null);

            // Загружаем XSLT-шаблон из файла
            Transformer transformer = transformerFactory.newTransformer(new StreamSource(new File(xsltFilePath)));

            // Загружаем XML-данные из файла
            StreamSource xmlStreamSource = new StreamSource(new File(xmlInputPath));

            // Применяем XSLT-преобразование
            transformer.transform(xmlStreamSource, new StreamResult(new File(outputPath)));

        } catch (Exception e) {
            System.out.println(e.getMessage() + "\n" + Arrays.toString(e.getStackTrace()));
        }
    }

    /**
     * Класс констант
     */
    public static class PathConstants {
        /**
         * Путь к исходному файлу data.xml
         */
        public static String DATA_XML = "src/main/resources/data.xml";

        /**
         * Пути к файлам xslt
         */
        public static String TASK_1_1 = "src/main/resources/transform/Task-1.1.xslt";
        public static String TASK_1_2 = "src/main/resources/transform/Task-1.2.xslt";
        public static String TASK_2 = "src/main/resources/transform/Task-2.xslt";
        public static String TASK_3 = "src/main/resources/transform/Task-3.xslt";
        public static String TASK_4 = "src/main/resources/transform/Task-4.xslt";
        public static String TASK_5 = "src/main/resources/transform/Task-5.xslt";

        /**
         * Пути к выходным файлам
         */
        public static String OUTPUT_1_1 = "src/main/resources/output/output1-1.xml";
        public static String OUTPUT_1_2 = "src/main/resources/output/output1-2.xml";
        public static String OUTPUT_2 = "src/main/resources/output/output2.xml";
        public static String OUTPUT_3 = "src/main/resources/output/output3.xml";
        public static String OUTPUT_4 = "src/main/resources/output/output4.xml";
        public static String OUTPUT_5 = "src/main/resources/output/output5.xml";
    }
}