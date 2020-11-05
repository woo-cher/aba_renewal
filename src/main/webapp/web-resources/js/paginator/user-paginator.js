/**
 * This class is used for paging `user` objects
 *
 * @see PageHelper
 */
class UserPaginator extends PageHelper {
    constructor(pageLength, bindingArea) {
        super(pageLength);
        this.bindingArea = bindingArea;
    }

    deleteUser(userId, removeElementTarget) {
        //
    }

    bindUsers(page, pageInfo) {
        let users = pageInfo['list'];
        let count = 0;

        this.bindingArea.empty();

        for(let i = 0; i < users.length; i++) {
            let user = users[i];

            this.bindingArea.append(`
                <tr>
                    <td>
                        <input type="checkbox" class="checkbox" id="'${user.userId}'" onclick="onChecked($(this))">
                    </td>
                    <td>${user.userId}</td>
                    <td>${user.name}</td>
                    <td>${user.nickName == null ? "미설정" : user.nickName}</td>
                    <td>${user.phone}</td>
                    <td>${user.email}</td>
                    <td class="aba">${user.type.value}</td>
                    <td class="aba">${user.role.value}</td>
                    <td width="10%">
                        <span class="border-side">
                            <i class="fas fa-eye" onclick="window.open('/admin/users/user_detail?id='.concat('${user.userId}'))"></i>
                            <i class="fas fa-pen"></i>
                            <i class="fas fa-trash-alt"></i>
                        </span>
                    </td>
                </tr>
            `)
        }
    }
}
