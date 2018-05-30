import React, {Component} from 'react';

// images import
import Imac1 from "./../images/Imac1.png";
import Imac1_p_500 from "./../images/Imac1-p-500.png";
import Imac2 from "./../images/Imac2.png";
import Imac3 from "./../images/Imac3.png";
import Imac4 from "./../images/Imac4.png";
import Imac5 from "./../images/Imac5.png";

class MainBlock extends Component {
    render() {
        return (
            <div id="home" className="main-block">
                <div className="main-decor">
                    <div className="main-decor-2"></div>
                    <div className="main-dector-1"></div>
                </div>
                <div className="container">
                    <div className="main-block__inner">
                        <div className="i-mac-container">
                            <img src={Imac1} width="709"
                                 srcSet={`${Imac1_p_500}  500w,${Imac1}  709w,`}
                                 sizes="(max-width: 479px) 94vw, (max-width: 738px) 96vw, (max-width: 991px) 709px, 49vw"
                                 data-w-id="6d7499fa-175a-b10a-9878-30c27e18d146"
                                 className="i-mac" alt=""/>
                            <img src={Imac2} alt="" data-w-id="520217b1-4cd6-c53e-05c1-971242dd8286"
                                 className="image-4"/>
                            <img src={Imac4} alt="" data-w-id="bd93c23f-61c3-78bd-9291-d59dcd310baa"
                                 className="image-2"/>
                            <img src={Imac3}
                                 data-w-id="13572f80-d93a-0de8-ef5a-b33428e7d364"
                                 className="image-5 topfadein" alt=""/>
                            <img src={Imac5}
                                 data-w-id="26ec2792-7c7d-c2d1-8dfd-e55c0243c635"
                                 className="image-3" alt=""/>
                        </div>
                        <div className="main-content">
                            <h1 className="h1-main"><span className="small-main-h1">Одностраничный</span> <br/>Интернет-магазин
                            </h1>
                            <h2 className="h2-main">Гарантированное увеличение конверсии &nbsp;с 0,3% до 5% и выше!</h2>
                            <div className="main-icons">
                                <div className="bilits">
                                    <div className="bulit-item">
                                        <div className="bulit-icon"></div>
                                        <div className="bulit-title">Быстрые заказы</div>
                                        <div className="bulit-text">Первая продажа в день запуска рекламы</div>
                                    </div>
                                    <div className="bulit-item">
                                        <div className="bulit-icon"></div>
                                        <div className="bulit-title">Новые контакты</div>
                                        <div className="bulit-text">Каждый новый контакт -потенциальный покупатель</div>
                                    </div>
                                    <div className="bulit-item">
                                        <div className="bulit-icon"></div>
                                        <div className="bulit-title">Рост прибыли</div>
                                        <div className="bulit-text">Больше продаж при меньших расходах</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default MainBlock;