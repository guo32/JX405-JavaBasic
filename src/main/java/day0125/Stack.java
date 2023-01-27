package day0125;

public class Stack {
    private int[] array = new int[0];
    private int top;

    public Stack() {
        top = -1;
    }

    public boolean empty() {
        // top이 -1일 때
        return top == -1;
    }

    public int size() {
        // 현재 배열의 크기 반환
        return array.length;
    }

    public void peek() {
        if(!empty()) {
            // top에 위치하는 원소의 값 출력
            System.out.println("peek(): " + array[top]);
        } else {
            System.out.println("Stack is empty.");
        }
    }

    public void pop() {
        if (!empty()) {
            // top에 위치하는 원소의 값 출력
            System.out.println("pop(): " + array[top]);
            // top에 위치하는 원소 제거
            int[] temp = new int[top];
            for (int i = 0; i < top; i++) {
                temp[i] = array[i];
            }
            array = temp;
            top--;
        } else {
            System.out.println("Stack is empty.");
        }
    }

    public void push(int e) {
        int[] temp = new int[size() + 1];
        for (int i = 0; i < size(); i++) {
            temp[i] = array[i];
        }
        temp[++top] = e;
        array = temp;
    }

    public int search(int e) {
        for (int i = top; i >= 0; i--) {
            if (array[i] == e) {
                return top - i + 1;
            }
        }
        return -1;
    }
}