import { LightningElement, track } from 'lwc';

export default class TestComponent extends LightningElement {

    /* Challenge 1
    input = 'hello world!';
    myBool = true;

    handleChange() {
        //let input = this.template.querySelector('.input').value;
        // OR
        this.input = this.refs.input.value;
        
    }*/
        @track
        todoItems = ['Task1'];

        handleChange() {
            const newTask = this.template.querySelector('.input').value;
            if (newTask) {
                this.todoItems = [...this.todoItems, newTask];  
                this.template.querySelector('.input').value = ''; 
            }
        }

        handleDelete(event) {
            const taskToRemove = event.target.dataset.task;
            this.todoItems = this.todoItems.filter(task => task !== taskToRemove); 
        }
    
}